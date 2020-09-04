#!/usr/bin/env bash

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
