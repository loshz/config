function __prompt {
	local EXIT="$?"
	local RESET="\[\e[0m\]"
	local RED="\[\e[1;31m\]"
	local GREEN="\[\e[1;32m\]"

	PS1="${GREEN}[\u@\h] \W \\$ ${RESET}"
	if [ "${EXIT}" -ne 0 ]; then
		PS1="${RED}${EXIT}${RESET} ${PS1}"
	fi
}

PROMPT_COMMAND=__prompt

shopt -s direxpand
shopt -s checkwinsize

set show-all-if-unmodified on

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export TERM="xterm-256color"
export EDITOR="nvim"
export DEVPATH="$HOME/dev"
export PATH="$HOME/.cargo/bin:$HOME/go/bin:$HOME/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
export HISTSIZE=2500
export HISTFILESIZE=2500
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%d/%m/%y %T  "
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"

alias bashconf="$EDITOR $HOME/.bashrc"
alias nvimconf="$EDITOR $HOME/.config/nvim/init.vim"
alias i3conf="$EDITOR $HOME/.config/i3/config"
alias rm="rm -i"
alias vim=$EDITOR
alias ls="ls -ahl --color=auto"
alias grep="grep --color=always --exclude-dir=.git"
alias diff='diff --color=always'
alias copy="xclip -sel clipboard"
alias pacman="sudo pacman"
alias genpass="cat /dev/urandom | tr -dc 'A-Za-z0-9!@#$%^&*()-_=+[]{};:,.<>/?' | head -c 50"

if [ -f $HOME/.bashrc.local ]; then
	source $HOME/.bashrc.local
fi

if [ -d /etc/bash_completion.d ]; then
	for completion in /etc/bash_completion.d/* ; do
		source $completion
	done
fi
