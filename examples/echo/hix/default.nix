{ hix, flake-utils, mkDarwinSystem, nixpkgs, home-manager, nix-darwin, ...
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
          inherit home-manager nixpkgs nix-darwin hix;
          hix-lib = import ./lib { inherit lib pkgs config hix; };
        };
      })
      (import ./modules)
    ];

    flakeOutputs = { pkgs, ... }@outputs:
      outputs // (with pkgs; {
        packages = pkgs;
        devShell = mkShell { pkgs = [ pkgSets.oeiuwq pkgSets.vic ]; };
      });

  })
