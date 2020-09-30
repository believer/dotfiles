let files = [
  \ 'plugins',
  \ 'general',
  \ 'key-mappings',
  \ 'plugin-settings',
  \ 'coc-settings',
  \ 'misc',
  \ ]

for file in files
  execute "source ~/.dotfiles/nvim/" . file . ".vim"
endfor
