export EDITOR='vim'
export PATH=${HOME}/.cargo/bin:${HOME}/bin:/usr/local/bin:${PATH}
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
