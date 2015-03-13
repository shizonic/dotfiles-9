# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
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

# Dircolors on completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# if there are more than 5 options allow selecting from a menu
zstyle ':completion:*' menu select=5
# complete manual by their section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections   true
zstyle ':completion:*:man:*' menu yes select

export PATH=$PATH:$HOME/.local/bin
export PROMPT='%B%2~%b %(!.#.>) '
export EDITOR=vim
eval $(dircolors $HOME/.config/dir_colors)

alias ls="ls --color=auto --file-type"
alias grep="grep --colour=auto"
alias ix="curl -F 'f:1=<-' ix.io"
function w3ms(){ w3m "https://startpage.com/do/search?query=$*" }
alias kpcli="kpcli --histfile /dev/null"
alias ytdl="youtube-dl -o '%(title)s.%(ext)s' --no-part --restrict-filenames $*"
function aurdiff() { cd ~/pkg/$1; vimdiff {,https://aur.archlinux.org/packages/"${1:0:2}/$1/"}PKGBUILD }

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[01;31m") \
		LESS_TERMCAP_md=$(printf "\e[01;38;5;74m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[38;5;246m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[04;38;5;146m") \
			man "$@"
}
