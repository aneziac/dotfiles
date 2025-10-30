{ config, pkgs, lib, mySystem, ... }:
let
  isLinux  = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;

  isMint = mySystem == "mint";
  isArch = mySystem == "arch";
in {
  programs.home-manager.enable = true;

  home.username      = if isDarwin then "Nate"        else "nate"      ;
  home.homeDirectory = if isDarwin then "/Users/Nate" else "/home/nate";

  nixpkgs.config.allowUnfree = true;
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
    } // lib.optionalAttrs (!isDarwin) {
      bat = "batcat";
    };

    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    } // lib.optionalAttrs (!isDarwin) {
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
    git-lfs
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
    delta
    ripgrep
    fd
    jq
    yq
    gh
    htop
    scooter
    spotify-player
    zathura
    timewarrior
    hostess
    opencode

    # Containers / builds
    docker
    just
    # terraform

    # Media
    ffmpeg
    imagemagick
    p7zip

    # Terminal
    tmux
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
    # valgrind
    gef
    gnumake
    gcc

    ## Misc
    typst
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

  ] ++ lib.optionals isLinux [
    # System
    bluez
    bluez-tools
    pavucontrol

  ] ++ lib.optionals isMint [
    # WM
    i3
    (polybar.override {
      i3Support = true;
      pulseSupport = true;
    })
    picom
    rofi
    # UX
    playerctl
    brightnessctl

  ] ++ lib.optionals isArch [
    # WM
    niri
    waybar
    fuzzel
    mako

    # Utils
    grim
    slurp
    wl-clipboard

    # GUI
    alacritty
    firefox
    code
    spotify
    discord
    bitwarden-desktop
    gpick
    gthumb
    xournalpp
    libreoffice-qt6-fresh
    obs-studio
    steam
    whatsapp-electron
    gimp3
    zoom-us

  ] ++ lib.optionals isDarwin [
    aerospace
  ];

  home.stateVersion = "25.05";
}
