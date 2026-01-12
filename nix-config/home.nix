{ config, pkgs, lib, mySystem, neovim-nightly, ... }:
let
  isLinux  = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;

  isMint = mySystem == "mint";
  isArch = mySystem == "arch";

  unstable = import <nixpkgs-unstable> {};
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
    dust
    tldr
    atuin
    ngrok
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
    (python3.withPackages (ps: with ps; [
      debugpy
      jupyter
    ]))
    ruff
    uv

    ## JS / TS
    nodejs
    typescript

    ## Rust, C/C++
    rustup
    gef
    gnumake
    pkg-config
    gcc

    ## Misc
    unstable.typst
    nodePackages.markdownlint-cli
    go
    lua

    # Formatters
    stylua
    nodePackages.prettier

    # LSP servers
    lua-language-server
    pyright
    typescript-language-server
    clang-tools
    gopls
    unstable.tinymist

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
    neovim-nightly
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
    colima
  ];

  home.activation = {
    rustupSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if ! ${pkgs.rustup}/bin/rustup toolchain list 2>/dev/null | grep -q "(default)"; then
        $DRY_RUN_CMD ${pkgs.rustup}/bin/rustup default stable
        $DRY_RUN_CMD ${pkgs.rustup}/bin/rustup component add rust-analyzer
      fi
    '';

    brewBundle = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -f $HOME/.Brewfile ]; then
        $DRY_RUN_CMD /opt/homebrew/bin/brew bundle --global
      fi
    '';
  };

  home.stateVersion = "25.11";
}
