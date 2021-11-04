"------------------------------------------------------------
" Plugins {{{1
"
call plug#begin('~/.vim/plugged')
  Plug 'mattn/emmet-vim' " Easy html
  Plug 'easymotion/vim-easymotion' " Jump easily through the buffer and better search
  Plug 'tpope/vim-surround' " Surround words something
  Plug 'tpope/vim-repeat' " Enhance . repeat
  Plug 'SirVer/ultisnips' " Snippets
  Plug 'Yggdroot/indentLine' " Display line indents
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Search
  Plug 'junegunn/fzf.vim' " Search Ag/Rg
  Plug 'mhinz/vim-startify' " Start screen
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " CoC.nvim
  Plug 'tpope/vim-fugitive' " All things git
  Plug 'kshenoy/vim-signature' " Easier setup for marks
  Plug 'dyng/ctrlsf.vim' " Uses ripgrep for easier editing of multiple places
  Plug 'Konfekt/FastFold'

  " NERDTree - File explorer
  Plug 'preservim/nerdtree'
  " Plug 'lambdalisue/fern.vim'
  Plug 'antoinemadec/FixCursorHold.nvim' " Fixes performance issues with CursorHold in neovim

  " Comments
  " <count>gcc - toggle line(s) comment
  " gc - comment with motion, e.g. gcap for paragraph
  " gcgc - uncomment
  Plug 'tpope/vim-commentary'

  " Ruby
  Plug 'thoughtbot/vim-rspec'

  " Syntax
  Plug 'luochen1990/rainbow' " Rainbow brackets
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " styled-components
  Plug 'ryyppy/vim-rescript' " ReScript
  Plug 'sheerun/vim-polyglot' " Installs a bunch of languages
  Plug 'tmsvg/pear-tree' " Bracket pairs

  " Themes
  Plug '~/code/personal/night-owl'
  Plug 'vim-airline/vim-airline'          " Airline status bar
  Plug 'vim-airline/vim-airline-themes'   " Airline themes

  " Personal plugins
  Plug '~/code/personal/cyclist.vim'
call plug#end()
