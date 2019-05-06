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
export GOPATH="$DEVPATH/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$HOME/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%d/%m/%y %T  "
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

alias bashconf="$EDITOR $HOME/.bashrc"
alias nvimconf="$EDITOR $HOME/.config/nvim/init.vim"
alias i3conf="$EDITOR $HOME/.config/i3/config"
alias rm=rm2
alias src="source $HOME/.bashrc"
alias vim=$EDITOR
alias ls="ls --color=auto"
alias grep="grep --color=always --exclude-dir=.git"
alias diff='diff --color=always'
alias copy="xclip -sel clipboard"
alias shutdown="shutdown now"
alias pacman="sudo pacman"
alias netctl="sudo netctl"

if [ -f $HOME/.bashrc.local ]; then
	source $HOME/.bashrc.local
fi

if [ -d /etc/.bash_completion.d ]; then
	for f in /etc/.bash_completion.d/* ; do
		. $f
	done
fi
