# Docker environments
source "$HOME/.config/zsh/docker"

# Aliases
source "$HOME/.dotfiles/aliases"

# ENV
export GOPATH=$HOME/Documents/Projects/go
export REACT_EDITOR=vim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export FZF_DEFAULT_COMMAND='fd --type f'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# Path
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="/Users/rickardlaurin/Documents/Projects/personal/flutter/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

# Android SDK
export ANDROID_HOME=${HOME}/Library/Android/sdk

# Path to your oh-my-zsh installation.
export ZSH=/Users/rickardlaurin/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

git-prune () {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

pgsql-restore () {
  pg_restore --verbose --clean -Fc -h $1 -p 5432 -U $2 -d $3 -C $4
}

itermprofile () {
  echo -e "\033]50;SetProfile=$1\a"
}

wejay () {
  ssh iteam@wejay.iteam.local
}

# added by travis gem
[ -f /Users/rickardlaurin/.travis/travis.sh ] && source /Users/rickardlaurin/.travis/travis.sh
