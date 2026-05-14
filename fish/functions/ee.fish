function ee --wraps=emacs --description 'alias ee doom emacs'
  emacsclient -t -a 'emacs' $argv
        
end
