# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U colors && colors
# Reduces the delay between vi modes in zsh, which is 4ms
KEYTIMEOUT=1

# Dircolors on completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# If there are more than 5 options, allow selecting from a menu
zstyle ':completion:*' menu select=5
# Complete manual by their section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections   true
zstyle ':completion:*:man:*' menu yes select

autoload disambiguate-keeplast
precmd() { disambiguate-keeplast }
source ~/dev/zsh-git-prompt/zshrc.sh
GIT_PROMPT_EXECUTABLE=haskell
PROMPT='$REPLY %(!.#.>) '
RPROMPT='$(git_super_status)'

setopt appendhistory \
  histexpiredupsfirst \
  correct \
  printexitvalue \
  nobgnice \
  nolistbeep

fpath+=~/.local/fpath

alias ls='ls --color=auto --file-type'
alias grep='grep --color=auto'
alias cp='cp --reflink=auto'
alias ix="curl -F 'f:1=<-' ix.io"
function w3ms() { w3m "https://startpage.com/do/search?query=$*" }
alias kpcli='kpcli --histfile /dev/null'
alias ytdl="youtube-dl -o '%(title)s.%(ext)s' --no-part --restrict-filenames $*"
function lsupd() { checkupdates; cower -ub --threads=1 }

function aurdiff() {
  # Supply package name unless ${PWD##*/} is said name
  [[ $1 ]] && local pkg=$1 && local pwd=$PWD || local pkg=${PWD##*/}
  vimdiff https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD\?h=$pkg \
    ${pwd:-~/pkg/cower/$pkg}/PKGBUILD
}

function aurpush() (
  branch=${"$(<.git/HEAD)"##*/}
  git push ssh://aur/$branch.git $branch:master
)

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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.vim/plugged/gruvbox/gruvbox_256palette.sh
