#!/usr/bin/env bash

declare -A FILES
FILES["nvim/init.vim"]="$HOME/.config/nvim"
FILES["nvim/dark.vim"]="$HOME/.config/nvim/colors"
FILES["zsh/.zshrc"]="$HOME"
FILES["zsh/terminal.zsh-theme"]="$HOME/.oh-my-zsh/themes"
FILES["git/.gitconfig"]="$HOME"

if [[ "$OSTYPE" == "linux"* ]]; then
	FILES["X/.Xresources"]="$HOME"
	FILES["X/.xinitrc"]="$HOME"
	FILES["i3/config"]="$HOME/.config/i3"
	FILES["i3/i3blocks.conf"]="$HOME/.config/i3"
fi

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
