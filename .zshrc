# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# Virtualenv - see https://gitlab.com/aDogCalledSpot/dotfiles/-/blob/master/zsh/.config/zsh/p10k.conf?ref_type=heads
POWERLEVEL9K_VIRTUALENV_CONTENT_EXPANSION='' # this fixes trailing whitespaces after the icon
POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=0
POWERLEVEL9K_VIRTUALENV_FOREGROUND="#ffffff"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="#6fc45e"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# https://www.youtube.com/watch?v=mmqDYw9C30I

# fzf key bindings
# source /usr/share/doc/fzf/examples/key-bindings.zsh

# -- Use fd instead of fzf --

# export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
#   fd --hidden --exclude .git . "$1"
# }
#
# # Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
#   fd --type=d --hidden --exclude .git . "$1"
# }

if [[ $(uname) == "Linux" ]]; then
    alias bat="batcat"
    export DOCKER_HOST=unix:///var/run/docker.sock
fi

alias ls="eza --color=always --long --icons=always --no-user" # --git
eval "$(zoxide init zsh)"

# PATH modifications
export PATH="$PATH:/opt/nvim"  # nvim
export PATH="$HOME/.elan/bin:$PATH"  # lean
export PATH="$HOME/.cargo/bin:$PATH"  # rust
export PATH="/usr/local/go/bin:$PATH"  # go

export PATH="$HOME/.local/bin:$PATH"

# homebrew
if [[ $(uname) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# BEGIN opam configuration (for OCaml)
if command -v opam >/dev/null 2>&1 && [[ -r "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
  eval "$(opam config env)"
fi
# END opam configuration

export VISUAL=nvim
export EDITOR="$VISUAL"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Vimlike editing
bindkey -v

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias v="nvim"

function copy-last-output() {
  local last_cmd=$(fc -ln -1)
  eval "$last_cmd" |xclip -selection clipboard # pbcopy (MacOS) / wl-copy (Wayland)
}

zle -N copy-last-output
bindkey '^O' copy-last-output

