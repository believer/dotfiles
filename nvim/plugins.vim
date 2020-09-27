"------------------------------------------------------------
" Plugins {{{1
"
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-tbone'
  Plug 'easymotion/vim-easymotion'
  Plug 'SirVer/ultisnips'
  Plug 'Yggdroot/indentLine'                                        " Display line indents
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Search
  Plug 'junegunn/fzf.vim'                                           " Search Ag/Rg

  Plug 'mhinz/vim-startify'                                       " Start screen
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}      " CoC.nvim
  Plug 'tpope/vim-fugitive'                                       " All things git
  Plug 'kshenoy/vim-signature'                                    " Easier setup for marks
  Plug 'dyng/ctrlsf.vim'                                          " Uses ripgrep for easier editing of multiple places
  Plug 'junegunn/goyo.vim'                                        " Distraction free writing

  " Fern.vim - File explorer
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'

  " Comments
  " <count>gcc - toggle line(s) comment
  " gc - comment with motion, e.g. gcap for paragraph
  " gcgc - uncomment
  Plug 'tpope/vim-commentary'

  " Ruby
  Plug 'tpope/vim-rails'
  Plug 'thoughtbot/vim-rspec'
  Plug 'ngmy/vim-rubocop'

  " Syntax
  Plug 'gerw/vim-HiLinkTrace'
  Plug 'luochen1990/rainbow'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'amiralies/vim-rescript'
  "" Installs a bunch of languages
  Plug 'sheerun/vim-polyglot'

  " Themes
  Plug '~/code/personal/night-owl'

  " Personal plugins
  Plug '~/code/personal/cyclist.vim'
call plug#end()

