if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Change shell to brew version
# sudo chsh -s $(which zsh) $(whoami)
# Add /opt/homebrew/bin to /etc/paths after /usr/local/bin

export DOTFILES_PATH="$HOME/.dotfiles"

setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt hist_ignore_space # ignore commands that start with space
HISTFILE=~/.zhistory

# CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/code

# Antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Setup terminal
source "$DOTFILES_PATH/terminal/init.sh"

# 10ms for key sequences
KEYTIMEOUT=1

# Hub
eval "$(hub alias -s)"

# https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-xv
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 3 # normal minimum is 2 (30 ms)

export PATH

# Setup terminal
source "$DOTFILES_PATH/terminal/init.sh"

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

