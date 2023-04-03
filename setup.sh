# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing Homebrew packages..."

brew install antibody
brew install bat
brew install fnm
brew install git
brew install gnupg # gpg
brew install kitty
brew install neovim
brew install opendevtools/supreme/supreme
brew install opendevtools/todos/todos
brew install ripgrep
brew install the_silver_searcher
brew install tmux
brew install tmuxinator

# Node LTS
echo "Installing Node..."
fnm install 18

# Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-watch

# Add yarn (> Node 16.10)
echo "Setup Yarn..."
corepack enable
