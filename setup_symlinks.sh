#!/bin/zsh

OS=$(uname)
if [[ $OS == "Darwin" ]]; then
	DOTFILES_DIR="/Users/Nate/Documents/Github/dotfiles"
elif [[ $OS == "Linux" ]]; then
	DOTFILES_DIR="/home/nate/code/dotfiles"
else
	echo "Unknown OS: $OS"
	exit 1
fi

DEST_DIR="$HOME"

# Excluded files from symlinking
EXCLUDES=(".git" ".gitignore" ".config" "." ".." "setup_symlinks.sh")

is_excluded() {
	local file_name=$(basename "$1")
	for exclude in "${EXCLUDES[@]}"; do
		if [[ "$file_name" == "$exclude" ]]; then
			return 0
		fi
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
