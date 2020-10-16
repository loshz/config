#!/usr/bin/env bash

declare -A FILES
FILES["nvim/init.vim"]="$HOME/.config/nvim"
FILES["nvim/dark.vim"]="$HOME/.config/nvim/colors"
FILES["tmux/.tmux.conf"]="$HOME"
FILES["git/.gitconfig"]="$HOME"
FILES["X/.Xresources"]="$HOME"
FILES["X/.xinitrc"]="$HOME"
FILES["i3/config"]="$HOME/.config/i3"
FILES["bash/.bashrc"]="$HOME"
FILES["bash/.bash_profile"]="$HOME"
FILES["polybar/config"]="$HOME/.config/polybar"
FILES["polybar/launch.sh"]="$HOME/.config/polybar"
FILES["rofi/config"]="$HOME/.config/rofi"
FILES["alacritty/alacritty.yml"]="$HOME/.config/alacritty"
FILES["redshift/redshift.conf"]="$HOME/.config/redshift"
FILES["conky/conky.conf"]="$HOME/.config/conky"
FILES["conky/launch.sh"]="$HOME/.config/conky"

COUNT=0
TOTAL=${#FILES[@]}

for i in "${!FILES[@]}"; do
	mkdir -p "${FILES[$i]}"
	FILE="${FILES[$i]}/${i##*/}"
	ln -sfv $HOME/.dotfiles/$i $FILE
	if [ $? -eq 0 ]; then
		((COUNT++))
	fi
done

echo -e "\nsuccessfully linked ${COUNT} out of ${TOTAL} files"
