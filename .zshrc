# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.bash_profile
export PATH=/opt/homebrew/bin:/Users/Nate/.nvm/versions/node/v22.3.0/bin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/anaconda3/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:/Library/Frameworks/Python.framework/Versions/3.8/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Developer/CommandLineTools/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/Nate/.cargo/bin
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

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/openjdk@17/bin:/opt/homebrew/opt/llvm/bin:/opt/homebrew/bin:/Users/Nate/.nvm/versions/node/v22.3.0/bin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/anaconda3/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:/Library/Frameworks/Python.framework/Versions/3.8/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Developer/CommandLineTools/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/Library/TeX/texbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/Nate/.cargo/bin"
