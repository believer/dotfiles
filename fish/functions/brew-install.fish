function brew-install --wraps='brew update && brew upgrade' --description 'alias brew-install brew update && brew upgrade'
  brew update && brew upgrade $argv
        
end
