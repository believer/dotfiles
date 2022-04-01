# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install antibody
brew install git
brew install fnm
brew install gnupg # gpg
brew install kitty
brew install fnm
brew install neovim
brew install opendevtools/supreme/supreme
brew install ripgrep
brew install the_silver_searcher
brew install tmux
brew install tmuxinator

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-watch

# Add yarn (> Node 16.10)
corepack enable
