# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ $(uname) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Virtualenv - see https://gitlab.com/aDogCalledSpot/dotfiles/-/blob/master/zsh/.config/zsh/p10k.conf?ref_type=heads
POWERLEVEL9K_VIRTUALENV_CONTENT_EXPANSION=''
POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=0
POWERLEVEL9K_VIRTUALENV_FOREGROUND="#ffffff"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="#6fc45e"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.p10k.zsh

# Tool initializations
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# Vim like editing
bindkey -v
bindkey '^G' clear-screen

# Copy last output
function copy-last-output() {
  local last_cmd=$(fc -ln -1)
  if [[ $(uname) == "Darwin" ]]; then
    eval "$last_cmd" | pbcopy
  else
    eval "$last_cmd" | xclip -selection clipboard
  fi
}
zle -N copy-last-output
bindkey '^O' copy-last-output
