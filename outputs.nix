{ self
, nixpkgs
, nur
, nix-darwin
, home-manager
# , flake-utils
# , flake-registry
# , emacs-overlay
# , fenix
}:
{
  packages.x86_64-darwin =
    let
      pkgs = import nixpkgs {
        overlays = self.darwinOverlays;
        system = "x86_64-darwin";
      };
    in
    {
      rust = pkgs.callPackage
        ({ buildEnv, rustc, clippy, rust-analyzer }:
         buildEnv {
           name = "${rustc.name}-tools";
           paths = [ clippy rust-analyzer ];
           pathsToLink = [ "/bin" ];
         }) { };
    };

  darwinOverlays = [
    (import ./nixpkgs/overlays/10-prefer-remote-fetch.nix)
    (import ./nixpkgs/overlays/20-weechat.nix)
  ];

  darwinConfigurations."echo" = nix-darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    modules = [ ./nixpkgs/darwin-configuration.nix ];
  };
}
