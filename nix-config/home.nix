{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;

  home.username = if pkgs.stdenv.isDarwin then "Nate" else "nate";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/Nate" else "/home/nate";

  home.packages = with pkgs; [
    # Core
    neovim
    git
    curl
    wget
    btop
    fzf
    ripgrep
    fd
    bat
    tree
 
    # Development
    nodejs
    python3
 
  ] ++ lib.optionals (!pkgs.stdenv.isDarwin) [
    i3
    polybar
    picom
  ];

  home.stateVersion = "24.05";
}
