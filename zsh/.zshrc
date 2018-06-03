export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="terminal"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
HIST_STAMPS="yyyy-mm-dd"

plugins=(aws git python docker golang sudo kubectl)

export EDITOR="nvim"
export GOPATH="$HOME/code/go"
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$HOME/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin"

alias zshconf="$EDITOR $HOME/.zshrc"
alias nvimconf="$EDITOR $HOME/.config/nvim/init.vim"
alias rm=rm2
alias src="source $HOME/.zshrc"
alias vim=nvim
alias git=hub
alias op=1p
alias t=tmux

source $ZSH/oh-my-zsh.sh

if [ -f ~/.zsh/local ]; then
	source ~/.zsh/local
fi
