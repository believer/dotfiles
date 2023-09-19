#!/usr/bin/env bash
# Custom functions

pgsql_restore() {
  pg_restore --verbose --clean -Fc -h $1 -p 5432 -U $2 -d $3 -C $4
}

kill_port() {
  lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9;
}

# Remove any .DS_Store files recursively inside the current directory
ds_store() {
  find . -name '.DS_Store' -type f -delete
}

# Pomodoro
# Created by @bashbunni
# https://gist.github.com/bashbunni/f6b04fc4703903a71ce9f70c58345106
work() { 
  timer ${1:-'60m'} && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal
}

rest() {
  timer ${1:-'10m'} && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -sound Crystal
}

nrt() {
  if [[ -f bun.lockdb ]]; then
    command bun test
  else
    command npm run test
  fi
}

