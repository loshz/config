#!/bin/bash

declare -A FILES
FILES["nvim"]="$HOME/.config/nvim/init.vim"
FILES["zsh"]="$HOME/.zshrc"
FILES["zsh-theme"]="$HOME/.oh-my-zsh/themes/terminal.zsh-theme"
FILES["Xresources"]="$HOME/.Xresources"

COUNT=0
TOTAL=${#FILES[@]}

for i in "${!FILES[@]}"
do
  ln -sf $PWD/files/$i ${FILES[$i]}
  if [ $? -eq 0 ]
  then
	  ((COUNT++))
  fi
done

echo "successfully linked $COUNT out of $TOTAL files."
