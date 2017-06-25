autoload -Uz compinit colors disambiguate-keeplast
compinit
colors

setopt appendhistory \
  correct \
  histexpiredupsfirst \
  interactivecomments \
  nobgnice \
  nolistbeep \
  printexitvalue

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
KEYTIMEOUT=1

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=5
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections   true
zstyle ':completion:*:man:*' menu yes select

fpath+=~/.local/fpath
precmd() { disambiguate-keeplast }
source ~/code/zsh-git-prompt/zshrc.sh
GIT_PROMPT_EXECUTABLE=haskell
PROMPT='$REPLY %(!.#.>) '
RPROMPT='$(git_super_status)'

alias cp='cp --reflink=auto'
alias grep='grep --color=auto'
alias ix="curl -F 'f:1=<-' ix.io"
alias ls='ls --color=auto --file-type'

function aurpush() (
  branch=${"$(<.git/HEAD)"##*/}
  git push aur@aur.archlinux.org:$branch.git $branch:master
)

function man() {
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

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
