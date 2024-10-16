fish_config theme choose "TokyoNight Night"

# Path
fish_add_path "$JAVA_HOME/bin"
fish_add_path "$ANDROID_HOME/tools"
fish_add_path "$ANDROID_HOME/emulator"
fish_add_path "$ANDROID_HOME/platform-tools"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.pub-cache/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$GOPATH/bin"
fish_add_path "/bin"
fish_add_path "/opt/homebrew/bin"
fish_add_path "/usr/bin"
fish_add_path "/usr/local/sbin"
fish_add_path "/usr/local/bin"

if status is-interactive
  # Use vi keybindings in cmd line
  fish_vi_key_bindings
end
