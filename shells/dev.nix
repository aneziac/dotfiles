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
    tmux
    zsh
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  shellHook = ''
    export ZSH_AUTOSUGGEST_PATH="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    export ZSH_SYNTAX_HIGHLIGHTING_PATH="${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    export ZSH_POWERLEVEL10K_PATH="${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"

    if [ "$(basename $SHELL)" != "zsh" ]; then
      exec ${pkgs.zsh}/bin/zsh
    fi
  '';
}
