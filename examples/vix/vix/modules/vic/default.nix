{ config, pkgs, lib, vix, vix-lib, home-manager, nix-darwin, nixpkgs, ...
}@args:
let
  USER = "vic";
  HOME = "/v";
  DOTS = lib.mkOutOfStoreSymlink "/hk/dots";
in {
  _module.args = { inherit HOME USER DOTS; };

  # imports = [ ./git ./direnv ./ssh ./fish ./emacs ];

  users.users.${USER}.home = HOME;

  home-manager.users.${USER} = {
    programs.nix-index.enableFishIntegration = true;
    home.packages = config.pkgSets.${USER};

    home.file.".nix-out/vix".source = vix;
    home.file.".nix-out/dots".source = DOTS;
    home.file.".nix-out/nixpkgs".source = nixpkgs;
    home.file.".nix-out/nix-darwin".source = nix-darwin;
    home.file.".nix-out/home-manager".source = home-manager;

    home.activation = {
      aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ln -sfn $genProfilePath/home-path/Applications "$HOME/Applications/Home Manager Applications"
      '';
    };
  };

}
