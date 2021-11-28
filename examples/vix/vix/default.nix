{ vix, flake-utils, mkDarwinSystem, nixpkgs, home-manager, nix-darwin, ...
}@inputs:
let
  hostName = "echo";
  systems = [ "x86_64-darwin" ];
in flake-utils.lib.eachSystem systems (system:
  mkDarwinSystem {
    inherit hostName system;

    nixosModules = [
      ({ config, pkgs, lib, ... }: {
        config._module.args = {
          inherit home-manager nixpkgs nix-darwin vix;
          vix-lib = import ./lib { inherit lib pkgs config vix; };
        };
      })
      (import ./modules)
    ];

    flakeOutputs = { pkgs, ... }@outputs:
      outputs // (with pkgs; {
        packages = pkgs;
        devShell = mkShell { pkgs = [ pkgSets.vico pkgSets.vic ]; };
      });

  })
