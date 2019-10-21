pathadd() {
  newelement=${1%/}
  if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$newelement($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH="$PATH:$newelement"
    else
      PATH="$newelement:$PATH"
    fi
  fi
}

pathrm() {
  PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

# Path
pathadd "/usr/local/bin"
pathadd "/usr/bin"
pathadd "/bin"
pathadd "$HOME/.fastlane/bin"
pathadd "$JAVA_HOME/bin"
pathadd "$ANDROID_HOME/tools"
pathadd "$ANDROID_HOME/platform-tools"
pathadd "$HOME/.yarn/bin"
pathadd "$HOME/.rvm/bin"
pathadd "$HOME/code/flutter/bin"
pathadd "$HOME/.pub-cache/bin"

# Antibody
export ZSH="${HOME}/.oh-my-zsh"
source <(antibody init)
antibody bundle < ~/.dotfiles/.zsh_plugins.txt

# Docker environments
source "$HOME/.config/zsh/docker"

# Aliases
source "$HOME/.dotfiles/aliases"

# ENV
export REACT_EDITOR=vim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export TERM=xterm-256color
export PYTHON_CONFIGURE_OPTS="--enable-framework"
export GOPATH="$HOME/code/go"
export EDITOR="nvim"

# 10ms for key sequences
KEYTIMEOUT=1

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Android SDK
export ANDROID_HOME=${HOME}/Library/Android/sdk

eval $(thefuck --alias)

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code

# Custom functions
git-prune () { git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D }
git-tag-diff () { git compare v$1..v$2 }
pgsql-restore () { pg_restore --verbose --clean -Fc -h $1 -p 5432 -U $2 -d $3 -C $4 }
itermprofile () { echo -e "\033]50;SetProfile=$1\a" }
wejay-ssh () { ssh iteam@wejay.iteam.local }
killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9; }

shorten-url () {
  if [ -n "$1" ]
  then
    pushd ~/code/personal/rlaur.in && npm run shorten $1 $2 && popd
  else
    echo "Missing parameters"
  fi
}

# added by travis gem
[ -f /Users/rickardlaurin/.travis/travis.sh ] && source /Users/rickardlaurin/.travis/travis.sh

# Hub
eval "$(hub alias -s)"

# fnm
pathadd $HOME/.fnm
eval `fnm env --multi`

function chpwd {
  set_fnm_version
}

function set_fnm_version {
  CWD=$(pwd)
  NVM_FILE="$CWD/.nvmrc"

  if [ -e "$NVM_FILE" ]; then
    CURRENT_VERSION=$(node -v)
    NODE_VERSION=$(cat $NVM_FILE)

    if [[ $CURRENT_VERSION == *"$NODE_VERSION"* ]]; then
      return;
    fi

    eval "fnm use"
    EXIT_CODE=$?

    if [ $EXIT_CODE -eq 1 ]; then
      eval "fnm install"
    fi
  fi
}

set_fnm_version

# https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-xv
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 3 # normal minimum is 2 (30 ms)

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Tmuxinator
source "$HOME/.dotfiles/scripts/tmuxinator.zsh"

# Kubectl
source <(kubectl completion zsh)

PS1="⚡️ "

export PATH
