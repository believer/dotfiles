fish_config theme choose "tokyonight-night"

# Path
set -Ux GOPATH "$HOME/code/go"
set --export BUN_INSTALL "$HOME/.bun"
set --export ANDROID_HOME "$HOME/Library/Android/sdk"
set --export RIPGREP_CONFIG_PATH "$HOME/.dotfiles/.ripgreprc"
set --export TMUXINATOR_CONFIG "$HOME/.dotfiles/tmuxinator"
set --export EDITOR "nvim"

fish_add_path "$JAVA_HOME/bin"
fish_add_path "$ANDROID_HOME/tools"
fish_add_path "$ANDROID_HOME/emulator"
fish_add_path "$ANDROID_HOME/platform-tools"
fish_add_path "$HOME/.local/share/bob/nvim-bin"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.pub-cache/bin"
fish_add_path "$XDG_CONFIG_HOME/nvim/mason/bin"
fish_add_path "$GOPATH/bin"
fish_add_path "/bin"
fish_add_path "/opt/homebrew/bin"
fish_add_path "/opt/homebrew/opt/libpq/bin"
fish_add_path "/usr/bin"
fish_add_path "/usr/local/sbin"
fish_add_path "/usr/local/bin"
fish_add_path "$BUN_INSTALL/bin"
fish_add_path "/Applications/love.app/Contents/MacOS"

if status is-interactive
  # Use vi keybindings in cmd line
  fish_vi_key_bindings
end

set -g fish_key_bindings fish_vi_key_bindings

# Added by `rbenv init` on Thu Oct 24 14:28:10 CEST 2024
status --is-interactive; and rbenv init - --no-rehash fish | source

# More dots, more cd ..
abbr --add dotdot --regex '^\.\.+$' --function multicd
