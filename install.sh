#!/usr/bin/env bash

declare -A FILES

# file specific symlinks
FILES["tmux/.tmux.conf"]="$HOME"
FILES["git/.gitconfig"]="$HOME"
FILES["X/.Xresources"]="$HOME"
FILES["X/.xinitrc"]="$HOME"
FILES["bash/.bashrc"]="$HOME"
FILES["bash/.bash_profile"]="$HOME"

# dir specific symlinks
FILES["alacritty"]="$HOME/.config/alacritty"
FILES["conky"]="$HOME/.config/conky"
FILES["i3"]="$HOME/.config/i3"
FILES["polybar"]="$HOME/.config/polybar"
FILES["nvim"]="$HOME/.config/nvim"
FILES["redshift"]="$HOME/.config/redshift"
FILES["rofi"]="$HOME/.config/rofi"

COUNT=0
TOTAL=${#FILES[@]}

for i in "${!FILES[@]}"; do
	if [[ -d $i ]]; then
		# if creating symlink for dir, we don't need
		# the individual file names
		FILE="${FILES[$i]}"
	else
		# if creating symlink for individual file,
		# we need to ensure the destination exists
		mkdir -p "${FILES[$i]}"

		# if creating symlink for individual file,
		# we need to get the individual file name
		FILE="${FILES[$i]}/${i##*/}"
	fi

	# remove any existing symlinks
	rm -rf $FILE

	# create symlink
	ln -sv $PWD/$i $FILE
	if [ $? -eq 0 ]; then
		((COUNT++))
	fi
done

echo -e "\nsuccessfully linked ${COUNT} out of ${TOTAL} files"
