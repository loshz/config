function __prompt {
	local EXIT="$?"
	local RESET="\[\e[0m\]"
	local RED="\[\e[1;31m\]"
	local GREEN="\[\e[1;32m\]"

	PS1="${GREEN}\u@\h:\W\\$ ${RESET}"
	if [ "${EXIT}" -ne 0 ]; then
		PS1="${RED}${EXIT}${RESET} ${PS1}"
	fi
}

PROMPT_COMMAND=__prompt

shopt -s direxpand
shopt -s checkwinsize
shopt -s histappend

set show-all-if-unmodified on

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export EDITOR="nvim"
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"
export HISTSIZE=2500
export HISTFILESIZE=2500
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%d/%m/%y %T  "
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --exclude .git/"

alias ..="cd .."
alias bashconf="$EDITOR $HOME/.bashrc"
alias nvimconf="$EDITOR $HOME/.config/nvim/lua/config.lua"
alias cat="bat --paging=never --color=never"
alias vim=$EDITOR
alias ls="ls -ahl --color=auto"
alias grep="rg -g '!.git'"
alias diff="diff --color=always"
alias dnf="sudo dnf"
alias tmpd="cd $(mktemp -d)"

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
