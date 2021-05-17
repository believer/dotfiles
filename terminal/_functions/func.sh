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

run() {
  supreme run
}

ni() {
  if [ $# -eq 0 ]; then
    supreme install
  else
    for pkg in "$@"
    do
      supreme install "$pkg"
    done
  fi
}

nisd() {
  for pkg in "$@"
  do
    supreme install --dev "$pkg"
  done
}

nu() {
  for pkg in "$@"
  do
    supreme uninstall "$pkg"
  done
}
