# Antigen
source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

antigen use oh-my-zsh
export NVM_AUTO_USE=true
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# Docker environments
source "$HOME/.config/zsh/docker"

# Aliases
source "$HOME/.dotfiles/aliases"

# ENV
export REACT_EDITOR=vim
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export FZF_DEFAULT_COMMAND='fd --type f'
export TERM=xterm-256color
export PYTHON_CONFIGURE_OPTS="--enable-framework"
# 10ms for key sequences
KEYTIMEOUT=1

# Android SDK
export ANDROID_HOME=${HOME}/Library/Android/sdk

# Path
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

eval $(thefuck --alias)

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Custom functions
git-prune () { git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D }
git-tag-diff () { git compare v$1..v$2 }
pgsql-restore () { pg_restore --verbose --clean -Fc -h $1 -p 5432 -U $2 -d $3 -C $4 }
itermprofile () { echo -e "\033]50;SetProfile=$1\a" }
wejay () { ssh iteam@wejay.iteam.local }
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
