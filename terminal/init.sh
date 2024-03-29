#!/usr/bin/env bash

pathadd() { newelement=${1%/}
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
pathadd "$JAVA_HOME/bin"
pathadd "$ANDROID_HOME/tools"
pathadd "$ANDROID_HOME/emulator"
pathadd "$ANDROID_HOME/platform-tools"
pathadd "$HOME/.yarn/bin"
pathadd "$HOME/.pub-cache/bin"
pathadd "$HOME/.local/share/nvim/mason/bin"
pathadd "$GOPATH/bin"
pathadd "/bin"
pathadd "/opt/homebrew/bin"
pathadd "/usr/bin"
pathadd "/usr/local/sbin"
pathadd "/usr/local/bin"

# Aliases
for aliasToSource in "$DOTFILES_PATH/terminal/_aliases/"*; do source $aliasToSource; done

# Exports
for exportToSource in "$DOTFILES_PATH/terminal/_exports/"*; do source $exportToSource; done

# Functions
for functionToSource in "$DOTFILES_PATH/terminal/_functions/"*; do source $functionToSource; done

