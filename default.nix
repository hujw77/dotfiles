{ nixpkgs, self, ... }@args:
(nixpkgs.lib.fix (mkDarwinSystem:
  { hostName, nixpkgs, nix-darwin, flake-utils, home-manager
  , system ? builtins.currentSystem or "x86_64-darwin", nixosModules ? [ ]
  , specialArgs ? nixpkgs.lib.id, flakeOutputs ? nixpkgs.lib.id
  , silliconOverlay ? (silliconPkgs: intelPkgs: { }), ... }@args:
  let
    darwinConfig = import "${nix-darwin}/eval-config.nix" {
      inherit (nixpkgs) lib;
    };

    # adapted from home-manager
    mkOutOfStoreSymlink = path:
      let
        pkgs = import nixpkgs { inherit system; };
        pathStr = toString path;
        name = home-manager.lib.hm.strings.storeFileName (baseNameOf pathStr);
      in pkgs.runCommandLocal name { }
      "ln -s ${nixpkgs.lib.escapeShellArg pathStr} $out";

    nixpkgsOverlay = (new: old: {
      darwinConfigurations.${hostName}.system = defaultPackage;
      sysEnv = new.buildEnv {
        name = "sysEnv";
        paths = nixosConfiguration.config.environment.systemPackages;
      };
    });

    activationDiffModule = { pkgs, config, ... }: {
      system.activationScripts.diffClosures.text = ''
        if [ -e /run/current-system ]; then
          echo "new configuration diff" >&2
          $DRY_RUN_CMD ${pkgs.nixUnstable}/bin/nix store \
              --experimental-features 'nix-command' \
              diff-closures /run/current-system "$systemConfig" \
              | sed -e 's/^/[diff]\t/' >&2
        fi
      '';

      system.activationScripts.preActivation.text =
        config.system.activationScripts.diffClosures.text;
    };

    nixosConfiguration = darwinConfig {
      modules = [
        nix-darwin.darwinModules.flakeOverrides
        home-manager.darwinModules.home-manager
        {
          nixpkgs.config = {
            localSystem = system;
            crossSystem = system;
          };
          nixpkgs.overlays = [ nixpkgsOverlay ];
        }
        activationDiffModule
      ] ++ nixosModules;
      inputs = {
        inherit nixpkgs;
        darwin = nix-darwin;
      };
      specialArgs = specialArgs {
        lib = nixpkgs.lib.extend (self: super: {
          inherit (home-manager.lib) hm;
          inherit mkOutOfStoreSymlink;
        });
      };
    };

    defaultPackage = nixosConfiguration.system;
    devShell = nixosConfiguration.pkgs.mkShell {
      packages = [ nixosConfiguration.pkgs.sysEnv ];
    };
    defaultApp = flake-utils.lib.mkApp {
      drv = nixosConfiguration.pkgs.writeScriptBin "activate" ''
        ${defaultPackage}/sw/bin/darwin-rebuild activate --flake ${
          mkOutOfStoreSymlink ./.
        } "''${@}"
      '';
    };

    outputs = {
      inherit defaultApp defaultPackage devShell;
      pkgs = nixosConfiguration.pkgs;
      nixosConfigurations.${hostName} = nixosConfiguration;
    };

  in flakeOutputs outputs)) args
