{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    neovim
    tree
    dust
    curl
    wget
    atuin
    delta
    gh
    ripgrep
    fd
    fzf
    lazygit
    bat
    eza
    zoxide
    git
    procps
    tmux
    bashInteractive
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  shellHook = ''
    if [ "$(basename $SHELL)" != "zsh" ]; then
      exec ${pkgs.zsh}/bin/zsh
    fi
  '';
}
