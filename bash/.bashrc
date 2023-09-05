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

function tmpd {
	local tmp_dir

	if [[ -z $1 ]]; then
		tmp_dir=$(mktemp -d)
	else
		tmp_dir=$(mktemp -d --suffix=_$1)
	fi

	cd $tmp_dir
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
export PATH="$HOME/.cargo/bin:$HOME/go/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
export HISTSIZE=2500
export HISTFILESIZE=2500
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%d/%m/%y %T  "
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore --exclude .git/'

alias ..="cd .."
alias bashconf="$EDITOR $HOME/.bashrc"
alias nvimconf="$EDITOR $HOME/.config/nvim/init.vim"
alias i3conf="$EDITOR $HOME/.config/i3/config"
alias cat='bat --paging=never'
alias vim=$EDITOR
alias ls="ls -ahl --color=auto"
alias grep="rg -g '!.git'"
alias diff='diff --color=always'
alias copy="xclip -sel clipboard"
alias pacman="sudo pacman"

# Enable bash completion in interactive shells.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source local system config.
if [ -f $HOME/.bashrc.local ]; then
	source $HOME/.bashrc.local
fi
