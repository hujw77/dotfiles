# ####
## > env NIX_CONF_DIR="$PWD" nix run
{
  description = "echo's Nix Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    mk-darwin-system.url = "../..";
    mk-darwin-system.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, mk-darwin-system, nixpkgs, ... }@inputs:
    import ./hix (mk-darwin-system.inputs // {
      hix = self;
      inherit nixpkgs;
      inherit (mk-darwin-system) mkDarwinSystem;
    });
}
