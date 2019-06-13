" Plugins
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-tbone'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'SirVer/ultisnips'
  Plug 'wakatime/vim-wakatime'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Yggdroot/indentLine'

  " Autocomplete
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'idanarye/vim-merginal'

  " NERDTree - File explorer
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Syntax
  Plug 'gerw/vim-HiLinkTrace'
  Plug 'luochen1990/rainbow'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'jparise/vim-graphql'
  Plug 'reasonml-editor/vim-reason-plus'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'thosakwe/vim-flutter'

  " Themes
  Plug 'haishanh/night-owl.vim'
  Plug '~/code/personal/night-owl'
call plug#end()

" Auto pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''"}

"" YATS
let g:yats_host_keyword = 1
autocmd BufNewFile,BufRead *.js set syntax=typescript

function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

command! -nargs=0 Syn call Syn()

" Rainbow
let g:rainbow_active = 1

let g:rainbow_conf = {
\	'guifgs': ['gold', 'orchid', 'lightskyblue'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan'],
\}

" CoC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Fugitive (Git)
nmap <silent> :gss :Gstatus<CR>
nmap <silent> :Gss :Gstatus<CR>

" EasyMotion
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfjö'
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Merginal
let g:merginal_windowWidth = '100'

" UltiSnips
let g:UltiSnipsSnippetsDir='~/.dotfiles/snippets'
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.dotfiles/snippets']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'

" NERDTree
nmap <Leader><Leader><Leader>ne :NERDTree<CR>
nmap <Leader><Leader><Leader>nf :NERDTreeFind<CR>

" Editor
set foldmethod=syntax
set foldlevelstart=99
set textwidth=80
set laststatus=2
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set background=dark
set termguicolors
syntax enable
colorscheme night-owl
set t_Co=256

"" Always display sign column (where errors are displayed)
set signcolumn=yes

"" Use vertical splits for diffs
set diffopt+=vertical

"" Disable scratch window preview
set completeopt-=preview

"" Set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
nnoremap q: <Nop>

nmap <CR> O<Esc>j

" Git diffs
" Start by doing :Gdiff, from vim-fugitive, on a conflicted file
"" Diffget from the left pane (merge branch)
nnoremap gdh :diffget //2<CR>
"" Diffget from right pane (target branch)
nnoremap gdl :diffget //3<CR>

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

" Flutter
let dart_format_on_save = 1

nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>

