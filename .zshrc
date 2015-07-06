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
# Reduces the delay between vi modes in zsh, which is 4ms
export KEYTIMEOUT=1

# Dircolors on completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# If there are more than 5 options, allow selecting from a menu
zstyle ':completion:*' menu select=5
# Complete manual by their section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections   true
zstyle ':completion:*:man:*' menu yes select

autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '✓'
zstyle ':vcs_info:*' unstagedstr '✖' 
export PROMPT='%2~ %(!.#.>) '
export RPROMPT='${vcs_info_msg_0_}'
precmd() { vcs_info }

setopt appendhistory \
  histexpiredupsfirst \
  correct \
  printexitvalue \
  nobgnice

export PATH=$PATH:$HOME/.local/bin
export EDITOR=vim
eval $(dircolors $HOME/.config/dir_colors)

alias ls="ls --color=auto --file-type"
alias grep="grep --color=auto"
alias ix="curl -F 'f:1=<-' ix.io"
function w3ms(){ w3m "https://startpage.com/do/search?query=$*" }
alias kpcli="kpcli --histfile /dev/null"
alias ytdl="youtube-dl -o '%(title)s.%(ext)s' --no-part --restrict-filenames $*"
function lsupd() { checkupdates; cower -ub }

function aurdiff() {
  [[ $1 ]] && local pkg=$1 || local pkg=${PWD##*/}
  local dir=${pkg:0:2}
  vimdiff {https://aur.archlinux.org/packages/$dir,~/pkg/cower}/$pkg/PKGBUILD
}

function aurpush() {
  pushd ~/pkg/repo
  local branch=$(git rev-parse --abbrev-ref HEAD)
  git push ssh://aur/${branch:-$1}.git ${branch:-$1}:master
  popd
}

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
