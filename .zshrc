# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U colors && colors
# Reduces the delay between vi modes in zsh, which is 4ms. (Thanks Earnestly)
export KEYTIMEOUT=1

export PATH=$PATH:$HOME/.local/bin
export PROMPT='%B%2~%b %(!.#.>) '
export EDITOR=vim

alias ls="ls --color=auto --file-type"
alias grep="grep --colour=auto"
alias ix="curl -F 'f:1=<-' ix.io"
function w3ms(){ w3m "https://startpage.com/do/search?query=$*" }
alias suspend=$HOME/.local/bin/suspend
alias kpcli="kpcli --histfile /dev/null"

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}
