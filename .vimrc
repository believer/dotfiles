" Plugins
call plug#begin('~/.vim/plugged')

 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'mattn/emmet-vim'
 Plug 'w0rp/ale'
 Plug 'scrooloose/nerdtree'
 Plug 'terryma/vim-multiple-cursors'
 Plug 'tpope/vim-surround'
 Plug 'Galooshi/vim-import-js'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-fugitive'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'easymotion/vim-easymotion'
 Plug 'prettier/vim-prettier', { 'do': 'npm install' }
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'jiangmiao/auto-pairs'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'

 " Syntax
 Plug 'pangloss/vim-javascript'
 Plug 'mxw/vim-jsx'
 Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
 Plug 'jparise/vim-graphql'
 Plug 'reasonml-editor/vim-reason-plus'

 Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': './install.sh',
  \ }

 Plug 'leafgarland/typescript-vim'
 Plug 'Shougo/vimproc.vim', { 'do': 'make' }
 Plug 'Quramy/tsuquyomi'

 " Themes
 Plug 'haishanh/night-owl.vim'
call plug#end()

" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'

" NERDTree
nmap <leader>ne :NERDTree<CR>
nmap <leader>nf :NERDTreeFind<CR>

" Prettier
let g:prettier#config#print_width = 80
let g:prettier#autoformat = 0
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'es5'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '⚠️'

let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['eslint'],
      \ 'reason': ['refmt'],
      \ }

" Language Client
let g:LanguageClient_serverCommands = {
  \ 'reason': ['/Users/rickardlaurin/code/lsp/reason-language-server.exe'],
  \ }
let g:deoplete#enable_at_startup = 1

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<cr>

" JS
let g:jsx_ext_required = 0

" Sneak
let g:sneak#s_next = 1

" Editor
set laststatus=2
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set termguicolors
syntax enable
set background=dark
set t_Co=256

"" Set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme night-owl
set ignorecase
highlight clear SignColumn
set smartcase
set autoread
au FocusGained * :checktime

"" Tabs
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smartindent

"" Save on loose focus
au FocusGained,BufEnter * :silent! !

"" Line numbers
set number relativenumber

" Remaps
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
map ; :Files<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Split panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remove arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
