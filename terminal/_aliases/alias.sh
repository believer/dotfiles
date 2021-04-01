#!/usr/bin/env bash

# Aliases
# https://codeburst.io/7-super-useful-aliases-to-make-your-development-life-easier-fef1ee7f9b73
alias nr='npm run '
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrt='npm run test'
alias nout='npm outdated'
alias nchecku='npx npm-check --update --save-exact'
alias ychecku='yarn upgrade-interactive --latest'
alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo '
alias l='ls -1a'
alias ll='l'
alias flush-npm='rm -rf node_modules && npm i'

# Git
alias git=hub
alias g='git'
alias gc='git commit'
alias gp='git push'
alias ga='git add'
alias gss='git status --short'

# Kubernetes
alias k='kubectl -n v2'

# Docker
alias d="docker"
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"'
alias ds='clear && docker service ps --format "table {{.Name}}\t{{.Image}}\t{{.CurrentState}}"'

# Dotfiles
alias tmuxconf='nvim $XDG_CONFIG_HOME/.tmux.conf'
alias vimrc='nvim $XDG_CONFIG_HOME/nvim/init.vim'
alias zshrc='nvim $XDG_CONFIG_HOME/.zshrc'
alias zshaliases='nvim $XDG_CONFIG_HOME/aliases'
alias zshdocker='nvim $XDG_CONFIG_HOME/docker'
alias szsh='source $XDG_CONFIG_HOME/.zshrc'

# App
alias e='nvim'
alias vim='nvim'
alias tmux='tmux -2'
alias f='fzf | xargs bat'

# Folders
alias dotfiles='cd ~/.dotfiles'
alias wid='cd ~/Dropbox/Dokument/what-i-did && nvim'
alias swap='cd ~/.local/share/nvim/swap'
alias node-prune='find . -name "node_modules" -type d -prune -exec rm -rf '{}' +'

# Swift
alias swiftformat="/usr/local/bin/swiftformat --indent 4"

# Rarely/never used
alias myip='curl http://ipecho.net/plain; echo'
alias gac='git add . && git commit -a -m '
alias hs='history | grep'
