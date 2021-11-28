{
  description = "Create a nixFlakes + nix-darwin + home-manager system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";

    # fenix.url = "github:nix-community/fenix";
    # fenix.inputs.nixpkgs.follows = "nixpkgs";


    # emacs-overlay.url = "github:nix-community/emacs-overlay";

    # flake-registry.url = "github:NixOS/flake-registry";
    # flake-registry.flake = false;

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    mkDarwinSystem = args: import ./default.nix (inputs // args);
  };
}
