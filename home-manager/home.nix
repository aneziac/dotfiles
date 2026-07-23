{ config, pkgs, lib, mySystem, self, ... }:

let
  isLinux  = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;

  isMint = mySystem == "mint";
  isArch = mySystem == "arch";

  devPackages        = (import (self + "/shells/dev.nix")        { inherit pkgs; }).buildInputs;
  systemsPackages    = (import (self + "/shells/systems.nix")    { inherit pkgs; }).buildInputs;
  pyPackages         = (import (self + "/shells/py.nix")         { inherit pkgs; }).buildInputs;
  functionalPackages = (import (self + "/shells/functional.nix") { inherit pkgs; }).buildInputs;
  tsPackages         = (import (self + "/shells/typescript.nix") { inherit pkgs; }).buildInputs;
  sciencePackages    = (import (self + "/shells/science.nix")    { inherit pkgs; }).buildInputs;
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
    devPackages ++ systemsPackages ++ pyPackages ++ functionalPackages
    ++ tsPackages ++ sciencePackages

    ++ (with pkgs; [
      # Container & build tools
      docker
      just
      lazydocker

      # Media processing
      imagemagick
      p7zip

      # Terminal utilities
      ngrok
      spotify-player
      timewarrior
      hostess

      # Languages & tools
      lua
      hugo
      foundry  # solidity

      # Formatters
      markdownlint-cli

      # LSP servers
      vscode-solidity-server
      universal-ctags

      # Misc
      fastfetch
      nmap
      claude-code

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

  home.stateVersion = "26.05";
}
