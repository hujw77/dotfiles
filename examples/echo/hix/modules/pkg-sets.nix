{ config, pkgs, lib, ... }: {
  options = with lib; {
    pkgSets = mkOption {
      type = types.attrsOf (types.listOf types.package);
      default = { };
      description = "Package sets";
    };
  };

  config = {

    pkgSets = with pkgs; {
      # System level packages
      hix = [ nixFlakes direnv home-manager ];

      # Home level packages
      echo = [
        bottom
        VimMotionApp
        xsv
        htop
        gitui
        xh # fetch things
        bat # better cat
        # browsh # Firefox on shell
        exa # alias ls
        fd # alias find
        fish # thanks for all the fish
        fzf # ctrl+r history
        # git-lfs # large binary files in git
        jq # query json
        ripgrep # grep faster
        # ripgrep-all # rg faster grep on many file types
        tig # terminal git ui
        # victor-mono # fontz ligatures
        # tor-browser # darkz web
        # firefox-developer # firefox with dev nicities
        # iterm2 # terminal
        # flux # late programming
        # pock # make touchbar useful
        # keybase # secure comms
        git
        neovim
      ];

      # Development environments
      scala = [
        openjdk11
        (mill.override { jre = openjdk11; })
        (coursier.override { jre = openjdk11; })
        (metals.override {
          jre = openjdk11;
          jdk = openjdk11;
        })
        dbmate
        gettext
        nodejs
        google-cloud-sdk # TODO: BACKPORT
        # jdk # TODO: build
        kubectl
        # coursierPackages.graalvm
        postgresql_12
        kubernetes-helm # deploy things
      ];

      bash = [ shfmt shellcheck ];

      nix = [
        niv # manage nix dependencies
        nixfmt # fmt nix sources
        nox # quick installer for nix
      ];
    };

    nixpkgs.overlays = [
      (new: old: {
        pkgShells =
          lib.mapAttrs (name: packages: old.mkShell { inherit name packages; })
          config.pkgSets;

        pkgSets =
          lib.mapAttrs (name: paths: old.buildEnv { inherit name paths; })
          config.pkgSets;
      })
    ];
  };
}
