# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# Virtualenv - see https://gitlab.com/aDogCalledSpot/dotfiles/-/blob/master/zsh/.config/zsh/p10k.conf?ref_type=heads
POWERLEVEL9K_VIRTUALENV_CONTENT_EXPANSION=''
# this fixes trailing whitespaces after the icon
POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=0
POWERLEVEL9K_VIRTUALENV_FOREGROUND="#ffffff"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="#6fc45e"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_THEME="powerlvel10k/powerlevel10k"
PROMPT='%B%F{cyan}%n %F{green}%~%f%b %# '

# fzf key bindings
eval "$(fzf --zsh)"

