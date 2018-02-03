#!/usr/bin/env bash

declare -A FILES
FILES["nvim"]=".config/nvim/init.vim"
FILES["zsh"]=".zshrc"
FILES["zsh-theme"]=".oh-my-zsh/themes/terminal.zsh-theme"
FILES["gitconfig"]=".gitconfig"

if [[ "$OSTYPE" == "linux"* ]]; then
	FILES["Xresources"]=".Xresources"
	FILES["i3"]=".config/i3/config"
	FILES["i3blocks"]=".config/i3/i3blocks.conf"
fi

COUNT=0
TOTAL=${#FILES[@]}

for i in "${!FILES[@]}"; do
  ln -sf $HOME/.dotfiles/files/$i $HOME/${FILES[$i]}
  if [ $? -eq 0 ]; then
	  ((COUNT++))
  fi
done

echo "successfully linked $COUNT out of $TOTAL files."
