{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    nur.url = "github:nix-community/NUR";

    # flake-utils.url = "github:numtide/flake-utils";

    # fenix.url = "github:nix-community/fenix";
    # fenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # emacs-overlay.url = "github:nix-community/emacs-overlay";

    # flake-registry.url = "github:NixOS/flake-registry";
    # flake-registry.flake = false;

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... } @ args: import ./outputs.nix args;
}
