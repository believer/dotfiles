" Plugins
call plug#begin('~/.vim/plugged')

 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'mattn/emmet-vim'
 Plug 'w0rp/ale'
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-tbone'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'easymotion/vim-easymotion'
 Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
 Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'wakatime/vim-wakatime'

 " Test runner
 Plug 'janko-m/vim-test'

 " Syntax
 Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
 Plug 'pangloss/vim-javascript'
 Plug 'jparise/vim-graphql'
 Plug 'reasonml-editor/vim-reason-plus'
 Plug 'leafgarland/typescript-vim'
 Plug 'maxmellon/vim-jsx-pretty'

 Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': './install.sh',
  \ }

 " Themes
 Plug 'haishanh/night-owl.vim'
call plug#end()

" Fugitive (Git)
nmap <silent> :gss :Gstatus<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'

" NERDTree
nmap <Leader><Leader><Leader>ne :NERDTree<CR>
nmap <Leader><Leader><Leader>nf :NERDTreeFind<CR>

" ALE
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '⚠️'

let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --semi false'
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'css': ['prettier'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'markdown': ['prettier'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'reason': ['refmt'],
      \ }
let g:ale_virtualtext_cursor = 1

" Language Client
let g:LanguageClient_serverCommands = {
  \ 'reason': ['/Users/rickardlaurin/code/lsp/reason-language-server.exe'],
  \ }
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0

nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

autocmd FileType typescript nnoremap <silent> K :TSType<CR>
autocmd FileType typescript nnoremap <silent> gd :TSDef<CR>
autocmd FileType reason nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
autocmd FileType reason nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>

" JS
let g:jsx_ext_required = 0

" Editor
set foldmethod=syntax
set foldlevelstart=99
set textwidth=80
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
highlight clear SignColumn
set autoread
au FocusGained * :checktime

"" Make commands ignore casing
set ignorecase
set smartcase

"" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
set conceallevel=2
set concealcursor=c
let g:markdown_syntax_conceal = 1
let g:markdown_folding = 1

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
