"------------------------------------------------------------
" Plugins {{{1
"
call plug#begin('~/.vim/plugged')
  Plug 'Asheq/close-buffers.vim' " Closing buffers
  Plug 'SirVer/ultisnips' " Snippets
  Plug 'Yggdroot/indentLine' " Display line indents
  Plug 'antoinemadec/FixCursorHold.nvim' " Fixes performance issues with CursorHold in neovim
  Plug 'dyng/ctrlsf.vim' " Uses ripgrep for easier editing of multiple places
  Plug 'easymotion/vim-easymotion' " Jump easily through the buffer and better search
  Plug 'github/copilot.vim' " GitHub Copilot
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Search
  Plug 'junegunn/fzf.vim' " Search Ag/Rg
  Plug 'kshenoy/vim-signature' " Easier setup for marks
  Plug 'Konfekt/FastFold' " Folding fix
  Plug 'mattn/emmet-vim' " Easy html
  Plug 'mhinz/vim-startify' " Start screen
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " CoC.nvim
  Plug 'nicwest/vim-camelsnek' " Convert casing
  Plug 'preservim/nerdtree' " NERDTree - File explorer
  Plug 'tpope/vim-fugitive' " All things git
  Plug 'tpope/vim-repeat' " Enhance . repeat
  Plug 'tpope/vim-surround' " Surround words something
  Plug 'zhimsel/vim-stay' " Restore folds in buffers

  " Comments
  " <count>gcc - toggle line(s) comment
  " gc - comment with motion, e.g. gcap for paragraph
  " gcgc - uncomment
  Plug 'tpope/vim-commentary'

  " Syntax
  Plug 'luochen1990/rainbow' " Rainbow brackets
  Plug 'rescript-lang/vim-rescript' " ReScript
  Plug 'sheerun/vim-polyglot' " Installs a bunch of languages
  Plug 'lepture/vim-jinja'

  " Themes
  Plug '~/code/personal/night-owl'
  Plug 'vim-airline/vim-airline'          " Airline status bar
  Plug 'vim-airline/vim-airline-themes'   " Airline themes

  " Personal plugins
  Plug '~/code/personal/cyclist.vim'
call plug#end()
