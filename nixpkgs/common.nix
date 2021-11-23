{ pkgs, config, lib, ... }:

{
  imports = [
    #./modules/neovim.nix
    # ./modules/emacs
  ];

  config = {
    home.packages = with pkgs; [
      # nur.repos.mic92.nixpkgs-review-unstable
      # nur.repos.mic92.mosh-ssh-agent
      # nur.repos.mic92.tmux-thumbs
      nix-prefetch

      gdb
      hexyl
      binutils
      clang-tools
      nixpkgs-fmt
      shfmt

      python3.pkgs.black
      pyright

      dua
      pkgs.nixFlakes

      tmux
      htop
      hub
      tig
      lazygit
      delta
      scc
      direnv
      (nix-direnv.override { enableFlakes = true; })
      fzf
      exa
      zoxide
      pinentry
      fd
      bat
      vivid
      ripgrep
      zsh
      less
      bashInteractive
      ncurses
      coreutils
      git
    ] ++ (lib.optionals pkgs.stdenv.isLinux [
      strace
      psmisc
      glibcLocales
    ]);

    home.stateVersion = "21.11";
    home.username = "echo";
    home.homeDirectory = "/Users/echo";
    programs.home-manager.enable = true;
  };
}
