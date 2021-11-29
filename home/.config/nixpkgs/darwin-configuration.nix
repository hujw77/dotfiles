{ self, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nix-prefetch

    gdb
    hexyl
    binutils
    nixpkgs-fmt
    shfmt

    dua

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
    ncurses
  ];

  users.users.echo = {
    name = "echo";
    home = "/Users/echo";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.package = pkgs.nix;
  nix.trustedUsers = [ "echo root" ];
  # https://github.com/NixOS/nix/issues/719
  nix.extraOptions = ''
    builders-use-substitutes = true
    keep-outputs = true
    keep-derivations = true
  '';
  nix.nixPath = [
    "nixpkgs-overlays=$HOME/.config/nixpkgs/overlays/"
  ];

  environment.shells = [ pkgs.fish ];
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.bash.enable = true;
  # programs.zsh.enable = true;
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
