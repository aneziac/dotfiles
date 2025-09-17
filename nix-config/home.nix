{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;

  home.username      = if pkgs.stdenv.isDarwin then "Nate"        else "nate"      ;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/Nate" else "/home/nate";

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "libsoup-2.74.3"
  # ];
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

    shellAliases = {
      l   = "eza --color=always --long --icons=always --no-user";
      v   = "nvim";
      lgt = "lazygit";
      ldk = "lazydocker";
    } // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
      bat = "batcat";
    };

    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    } // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
      DOCKER_HOST = "unix:///var/run/docker.sock";
    };

    initContent = lib.mkBefore ''source ~/.config/zsh/config.zsh'';
  };

  home.packages = with pkgs; [
    # Core
    zsh-powerlevel10k
    neovim
    age
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
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.meslo-lg
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
