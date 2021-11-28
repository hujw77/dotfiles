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
      vico = [ nixFlakes direnv home-manager ];

      # Home level packages
      vic = [
        # bottom
        # # VimMotionApp
        # xsv
        # htop
        # gitui
        # xh # fetch things
        # bat # better cat
        # # browsh # Firefox on shell
        # exa # alias ls
        # fd # alias find
        # fish # thanks for all the fish
        # fzf # ctrl+r history
        # # git-lfs # large binary files in git
        # jq # query json
        # ripgrep # grep faster
        # # ripgrep-all # rg faster grep on many file types
        # tig # terminal git ui
        # # victor-mono # fontz ligatures
        # # tor-browser # darkz web
        # # firefox-developer # firefox with dev nicities
        # # iterm2 # terminal
        # # flux # late programming
        # # pock # make touchbar useful
        # # keybase # secure comms
        # git
        # neovim
      ];

      bash = [ shfmt shellcheck ];

      nix = [
        niv # manage nix dependencies
        nixfmt # fmt nix sources
        nox # quick installer for nix
        nix-prefetch
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
