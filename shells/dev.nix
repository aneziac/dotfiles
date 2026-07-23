{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
  ] ++ (with pkgs; [
    # Core
    chezmoi
    age
    vim
    nix-tree
    neovim

    # Git
    git
    git-lfs
    gh
    delta
    lazygit

    # Shell
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
    bashInteractive
    tmux
    atuin

    # File navigation
    ripgrep
    fd
    fzf
    tree
    dust
    eza
    zoxide
    bat

    # Networking
    curl
    wget

    # System utilities
    procps
    htop
    unzip

    # Documentation
    tldr

    # Data processing
    jq
    yq
  ]);

  shellHook = ''
    # Auto-enter zsh if not already in it
    if [ "$(basename $SHELL)" != "zsh" ]; then
      exec ${pkgs.zsh}/bin/zsh
    fi
  '';
}
