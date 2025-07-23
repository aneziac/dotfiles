#!/bin/zsh

OS=$(uname)
if [[ $OS == "Darwin" ]]; then
	DOTFILES_DIR="$HOME/code/dotfiles"
elif [[ $OS == "Linux" ]]; then
	DOTFILES_DIR="$HOME/code/dotfiles"
else
	echo "Unknown OS: $OS"
	exit 1
fi

DEST_DIR="$HOME"

# Excluded files from symlinking
EXCLUDES=(.git .gitignore .config . .. *.sh *.txt)

is_excluded() {
	local file_name
	file_name=$(basename "$1")
	for pattern in "${EXCLUDES[@]}"; do
		case "$file_name" in
			$pattern)
				return 0
				;;
		esac
	done
	return 1
}

for file in "$DOTFILES_DIR"/.* "$DOTFILES_DIR"/*; do
	if is_excluded "$file"; then
		continue
	fi
	
	ln -sfn "$file" "$DEST_DIR/$(basename "$file")"
	echo "Linked $(basename "$file")"
done

for file in "$DOTFILES_DIR"/.config/*; do
	if is_excluded "$file"; then
		continue
	fi
	
	ln -sfn "$file" "$DEST_DIR/.config/$(basename "$file")"
	echo "Linked $(basename "$file")"
done

