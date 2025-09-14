{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;

  home.username = if pkgs.stdenv.isDarwin then "Nate" else "nate";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/Nate" else "/home/nate";

  home.packages = with pkgs; [
    # Core
    neovim
    vim
    git
    curl
    wget
    fzf
    unzip

    # Helpful nonessential CLI utils
    tree
    du-dust
    tldr
    atuin
    eza
    zoxide
    bat
    lazygit
    lazydocker
    binutils
    zathura

    # Containers / builds
    docker
    just
    terraform

    # Media
    ffmpeg
    imagemagick
    p7zip

    # Terminal
    tmux
    alacritty
    yazi
 
    # Development

    ## Python
    python3
    uv

    ## JS / TS
    nodejs
    typescript
    nodePackages.ts-node

    ## Rust
    rustc
    cargo
    rustfmt
    clippy

    ## C/C++
    valgrind
    gdb
    gnumake
    gcc

    # Typst
    typst
    tinymist

    # Misc
    go
    lua

    # UX
    neofetch

    # Networking
    nmap

    # Fonts
    # (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })

    # Recommended by Claude, try to incorporate into workflow
    delta
    ripgrep
    fd
    jq
    yq
    gh
    htop
  ] ++ lib.optionals (!pkgs.stdenv.isDarwin) [
    # WM
    i3
    polybar
    picom
    ulauncher

    # UX
    playerctl
    brightnessctl
  ] ++ lib.optionals (pkgs.stdenv.isDarwin) [
    aerospace
  ];

  home.stateVersion = "24.05";
}
