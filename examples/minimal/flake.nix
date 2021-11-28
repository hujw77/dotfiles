{
  description = "Minimal DarwinSystem example";

  inputs = {
    mk-darwin-system.url = "../..";
  };

  outputs = { mk-darwin-system, ... }@inputs:
    let
      flake-utils = mk-darwin-system.inputs.flake-utils;
      hostName = "echo";
      systems = [ "x86_64-darwin" ];
    in flake-utils.lib.eachSystem systems (system:
      mk-darwin-system.mkDarwinSystem {
        inherit hostName system;

        nixosModules = [
          ({ pkgs, ... }: {
            system.stateVersion = 4;
            services.nix-daemon.enable = true;
            nix.package = pkgs.nixFlakes;
            nix.extraOptions = ''
              system = x86_64-darwin
              extra-platforms = aarch64-darwin x86_64-darwin
              experimental-features = nix-command flakes
              build-users-group = nixbld
            '';
            environment.systemPackages = with pkgs; [ nixFlakes home-manager ];
          })
        ];

        flakeOutputs = { pkgs, ... }@outputs:
          outputs // (with pkgs; { packages = { inherit hello; }; });
      });
}
