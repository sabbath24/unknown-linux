export EDITOR='vim'
export ZSH=~/.oh-my-zsh
ZSH_THEME="imajes"
plugins=(
    docker
    git
    sudo
    tmux
)
source $ZSH/oh-my-zsh.sh
alias ssh='ssh -o "VerifyHostKeyDNS ask"'
