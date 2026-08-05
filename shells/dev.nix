{ pkgs }:

with pkgs; [
  # Core
  chezmoi
  age
  vim
  nix-tree
  neovim
  tree-sitter
  docker
  lazydocker
  lua

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

  # Editor tooling
  universal-ctags
]
