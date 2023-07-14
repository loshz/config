#!/usr/bin/env bash

declare -A FILES

# File specific symlinks.
FILES["tmux/.tmux.conf"]="$HOME"
FILES["git/.gitconfig"]="$HOME"
FILES["X/.Xresources"]="$HOME"
FILES["X/.xinitrc"]="$HOME"
FILES["bash/.bashrc"]="$HOME"
FILES["bash/.bash_profile"]="$HOME"

# Dir specific symlinks.
FILES["alacritty"]="$HOME/.config/alacritty"
FILES["conky"]="$HOME/.config/conky"
FILES["i3"]="$HOME/.config/i3"
FILES["polybar"]="$HOME/.config/polybar"
FILES["nvim"]="$HOME/.config/nvim"
FILES["rofi"]="$HOME/.config/rofi"

COUNT=0
TOTAL=${#FILES[@]}

echo -e "Installing config files..."

for i in "${!FILES[@]}"; do
	if [[ -d $i ]]; then
		# If creating symlink for dir, we don't need
		# the individual file names.
		FILE="${FILES[$i]}"
	else
		# If creating symlink for individual file,
		# we need to ensure the destination exists.
		mkdir -p "${FILES[$i]}"

		# If creating symlink for individual file,
		# we need to get the individual file name.
		FILE="${FILES[$i]}/${i##*/}"
	fi

    # Prompt user for confirmation.
	read -p "Install ${FILE} [y/N]: " answer
	if [[ -z "$answer" ]] || [[ "$answer" != "y" ]]; then
		echo "Skipping..."
		continue
	fi
	
	# Remove any existing symlinks.
	rm -rf $FILE

	# Create symlinks.
	ln -sv $PWD/$i $FILE
	if [ $? -eq 0 ]; then
		((COUNT++))
	fi
done

echo -e "\nSuccessfully linked ${COUNT} out of ${TOTAL} files."
