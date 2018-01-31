#!/bin/bash

declare -A FILES=( ["nvim"]="$HOME/.config/nvim/init.vim" ["zsh"]="$HOME/.zshrc" ["zsh-theme"]="$HOME/.oh-my-zsh/themes/terminal.zsh-theme" )
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
