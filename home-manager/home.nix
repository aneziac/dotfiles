{ config, pkgs, lib, mySystem, isDesktop, username, self, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;

  isMint = mySystem == "mint";

  devPackages = import (self + "/shells/dev.nix") { inherit pkgs; };
in {
  programs.home-manager.enable = true;

  home.username      = username;
  home.homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";

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
      dsh = "nix develop";
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
    devPackages

    ++ (with pkgs; lib.optionals isDesktop [
      # Container & build tools
      just
      docker

      # Media processing
      imagemagick
      p7zip

      # Terminal utilities
      ngrok
      timewarrior
      hostess

      # Misc
      fastfetch
      nmap
      claude-code

      # Fonts
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.meslo-lg
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

      bluez
      bluez-tools
      pavucontrol
    ]

    ++ lib.optionals isDarwin [
      colima
    ]
  );

  home.activation = {
    brewBundle = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -f $HOME/.Brewfile ]; then
        $DRY_RUN_CMD /opt/homebrew/bin/brew bundle --global
      fi
    '';
  };

  home.stateVersion = "26.05";
}
