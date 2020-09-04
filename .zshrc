export DOTFILES_PATH="$HOME/.dotfiles"

setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt hist_ignore_space # ignore commands that start with space
HISTFILE=~/.zhistory

# Antibody
export ZSH="${HOME}/.oh-my-zsh"
source <(antibody init)
antibody bundle < ~/.dotfiles/.zsh_plugins.txt

# Setup terminal
source "$DOTFILES_PATH/terminal/init.sh"

# Work
source ~/.dotfiles/.hemnetrc

# 10ms for key sequences
KEYTIMEOUT=1

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code

# added by travis gem
[ -f /Users/rickardlaurin/.travis/travis.sh ] && source /Users/rickardlaurin/.travis/travis.sh

# Hub
eval "$(hub alias -s)"

# https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-xv
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 3 # normal minimum is 2 (30 ms)

# Tmuxinator
source "$HOME/.dotfiles/scripts/tmuxinator.zsh"

PS1="⚡️ "

export PATH
