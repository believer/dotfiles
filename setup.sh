# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add /opt/homebrew/bin to /etc/paths after /usr/local/bin

echo "Installing Homebrew packages..."

brew install fish
brew install bat
brew install fnm
brew install fzf
brew install gh
brew install hub
brew install neovim
brew install opendevtools/supreme/supreme
brew install opendevtools/todos/todos
brew install ripgrep
brew install the_silver_searcher
brew install tmux
brew install tmuxinator

echo "Setting up GPG"
brew install gnupg # gpg
brew install keychain # add ability to save in keychain

# Set pinentry to use macos keychain
mkdir -m 0700 ~/.gnupg
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" | tee ~/.gnupg/gpg-agent.conf
pkill -TERM gpg-agent

# Node LTS
echo "Installing Node..."
fnm install --lts

# Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-watch

# Add yarn (> Node 16.10)
echo "Setup Yarn..."
corepack enable

# Setup FZF
echo "Setup FZF key bindings and auto-completion..."
$(brew --prefix)/opt/fzf/install

# Install programs
# Chrome
# Docker
