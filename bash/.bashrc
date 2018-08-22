__prompt_command() {
	local EXIT="$?"
	local TIME=$(date +%H:%M:%S)

	PS1=""
	
	local RESET="\[\e[0m\]"
	local RED="\[\e[0;31m\]"
	local GREEN="\[\e[0;32m\]"

	PS1+="${GREEN}[\u@\h] \W \\$ ${RESET}"

	if [ "${EXIT}" -ne 0 ]; then
		PS1+="${RED}${EXIT}${RESET} "
	fi
	
	PS1+="[${TIME}]"
}

PROMPT_COMMAND=__prompt_command

export EDITOR="nvim"
export DEVPATH="$HOME/dev"
export GOPATH="$DEVPATH/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$HOME/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"

alias bashconf="$EDITOR $HOME/.bashrc"
alias nvimconf="$EDITOR $HOME/.config/nvim/init.vim"
alias rm=rm2
alias src="source $HOME/.bashrc"
alias vim=nvim
alias op=1p
alias t=tmux
