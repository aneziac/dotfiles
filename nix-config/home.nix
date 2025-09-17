{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;

  home.username = if pkgs.stdenv.isDarwin then "Nate" else "nate";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/Nate" else "/home/nate";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  home.packages = with pkgs; [
    # Core
    chezmoi
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
    delta
    ripgrep
    fd
    jq
    yq
    gh
    htop
    scooter

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

    ## Typst
    typst
    tinymist

    ## Misc
    go
    lua

    # UX
    neofetch

    # Networking
    nmap

    # Fonts
    # (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ] ++ lib.optionals (!pkgs.stdenv.isDarwin) [
    # WM
    i3
    polybar
    picom
    # ulauncher

    # UX
    playerctl
    brightnessctl
  ] ++ lib.optionals (pkgs.stdenv.isDarwin) [
    aerospace
  ];

  home.stateVersion = "24.05";
}
