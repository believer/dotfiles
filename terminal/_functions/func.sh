#!/usr/bin/env bash
# Custom functions

git_prune() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

git_tag_diff() {
  git compare v$1..v$2
}

pgsql_restore() {
  pg_restore --verbose --clean -Fc -h $1 -p 5432 -U $2 -d $3 -C $4
}

kill_port() {
  lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9;
}

shorten_url() {
  if [ -n "$1" ]
  then
    pushd ~/code/personal/rlaur.in && npm run shorten $1 $2 && popd
  else
    echo "Missing parameters"
  fi
}

# https://sancho.dev/blog/better-yarn-npm-run/
run() {
	if cat package.json > /dev/null 2>&1; then
			selected_script=$(cat package.json | jq .scripts | sed '1d;$d' | fzf --cycle --height 40% --header="Press ENTER to run the script. ESC to quit." --history="$HOME/.zhistory");

			if [[ -n "$selected_script" ]]; then
					script_name=$(echo "$selected_script" | awk -F ': ' '{gsub(/"/, "", $1); print $1}' | awk '{$1=$1};1')
					print -s "npm run "$script_name;
					npm run $script_name;
			else
					echo "Exit: You haven't selected any script"
			fi
	else
			echo "Error: There's no package.json"
	fi
}
