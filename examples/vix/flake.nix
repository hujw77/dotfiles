# ####
## > env NIX_CONF_DIR="$PWD" nix run
{
  description = "Echo's Nix Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    mk-darwin-system.url = "../..";
    mk-darwin-system.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, mk-darwin-system, nixpkgs, ... }@inputs:
    import ./vix (mk-darwin-system.inputs // {
      vix = self;
      inherit nixpkgs;
      inherit (mk-darwin-system) mkDarwinSystem;
    });
}
