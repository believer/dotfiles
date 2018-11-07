" Plugins
call plug#begin('~/.vim/plugged')

 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug '/usr/local/opt/fzf'
 Plug 'junegunn/fzf.vim'
 Plug 'mattn/emmet-vim'
 Plug 'w0rp/ale'
 Plug 'scrooloose/nerdtree'
 Plug 'terryma/vim-multiple-cursors'
 Plug 'tpope/vim-surround'
 Plug 'Galooshi/vim-import-js'
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-fugitive'
 Plug 'autozimu/LanguageClient-neovim', {
       \ 'branch': 'next',
       \ 'do': 'install.sh'
       \ }

 " Deoplete
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'Shougo/neosnippet'
 Plug 'Shougo/neosnippet-snippets'
 Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

 " Syntax
 Plug 'jparise/vim-graphql'
 Plug 'pangloss/vim-javascript'
 Plug 'mxw/vim-jsx'
 Plug 'reasonml-editor/vim-reason-plus'

 " Themes
 Plug 'ayu-theme/ayu-vim'

call plug#end()

" Airline
let g:airline_theme='deus'
let g:airline#extensions#ale#enabled = 1

" ReasonML
let g:LanguageClient_serverCommands = {
      \ 'reason': ['/Users/rickardlaurin/Documents/Projects/lsp/reason-language-server.exe'],
      \ }

" Deoplete
set completeopt+=noinsert
set completeopt+=noselect
set completeopt=menu,preview
let g:deoplete#enable_at_startup = 1

let g:user_emmet_settings = {
      \ 'javascript': {
      \ 'extends': 'jsx',
      \ }}

" Ale
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '⚠️'

let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5 --semi false'
let g:ale_sign_column_always = 1
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'reason': ['refmt'],
      \ }

" JS
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Flow - use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" Editor
set laststatus=2
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set termguicolors
let ayucolor="mirage"
colorscheme ayu
highlight clear SignColumn
set ignorecase
set smartcase

"" Tabs
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab

"" Save on loose focus
au FocusGained,BufEnter * :silent! !

"" Line numbers
set number relativenumber

" Remaps
map ; :Files<CR>
map <C-o> :NERDTreeToggle<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Split panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
