export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="terminal"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
HIST_STAMPS="dd/mm/yyyy"

plugins=(aws git python docker docker-compose brew golang sudo httpie kubectl)

export EDITOR="nvim"
export GOPATH="$HOME/code/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"

alias zshconfig="$EDITOR $HOME/.zshrc"
alias nvimconfig="$EDITOR $HOME/.config/nvim/init.vim"
alias rm="$GOPATH/bin/rm2"
alias src="source $HOME/.zshrc"
alias git=hub

source $ZSH/oh-my-zsh.sh

if [ -f ~/.zsh/local ]; then
	source ~/.zsh/local
fi
