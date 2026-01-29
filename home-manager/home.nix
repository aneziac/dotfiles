{ config, pkgs, lib, mySystem, self, neovim-nightly, ... }:

let
  isLinux  = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;

  isMint = mySystem == "mint";
  isArch = mySystem == "arch";

  unstable = import <nixpkgs-unstable> {};

  devPackages = (import (self + "/shells/dev.nix") { inherit pkgs; }).buildInputs;
  cppPackages = (import (self + "/shells/cpp.nix") { inherit pkgs; }).buildInputs;
  pyPackages  = (import (self + "/shells/py.nix")  { inherit pkgs; }).buildInputs;
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

    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];

    shellAliases = {
      l   = "eza --color=always --long --icons=always --no-user";
      v   = "nvim";
      lgt = "lazygit";
      ldk = "lazydocker";
      dsh = "nix-shell --run zsh";
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

  home.packages =
    devPackages ++ cppPackages ++ pyPackages

    ++ (with pkgs; [
      # Container & build tools
      docker
      just
      lazydocker

      # Media processing
      ffmpeg
      imagemagick
      p7zip

      # Terminal utilities
      yazi
      ngrok
      scooter
      spotify-player
      zathura
      timewarrior
      hostess

      # Languages & tools
      tree-sitter
      nodejs
      typescript
      rustup
      go
      lua
      unstable.typst
      quarto
      obsidian

      # Formatters
      stylua
      nodePackages.prettier
      nodePackages.markdownlint-cli

      # LSP servers
      lua-language-server
      typescript-language-server
      gopls
      unstable.tinymist

      # Misc
      neofetch
      nmap


      # Fonts
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.meslo-lg
    ]

    ++ lib.optionals isLinux [
      bluez
      bluez-tools
      pavucontrol
    ]

    ++ lib.optionals isMint [
      i3
      (polybar.override {
        i3Support = true;
        pulseSupport = true;
      })
      picom
      rofi
      playerctl
      brightnessctl
    ]

    ++ lib.optionals isArch [
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
    ]

    ++ lib.optionals isDarwin [
      colima
    ]
  );

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
