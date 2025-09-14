# Set zsh as default shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
	echo "Changing default shell to zsh..."
	chsh -s "$(which zsh)"
else
	echo "zsh is already the default shell"
fi

