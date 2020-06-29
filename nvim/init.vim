"------------------------------------------------------------
" General {{{1
"
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

"" Syntax highlighting
syntax enable

"" Always display sign column (where errors are displayed)
set signcolumn=yes

"" Use vertical splits for diffs
set diffopt+=vertical

"" Disable scratch window preview
set completeopt-=preview

"" Display tabs, non-breaking space and trailing whitespace
set listchars=tab:>~,nbsp:_,trail:.
set list

"" Make commands ignore casing
set ignorecase
set smartcase

"" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
set conceallevel=0

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

"" Folding
set foldmethod=syntax
set foldlevelstart=99

"" Always display status line
set laststatus=2

"" Theme and color settings
set termguicolors
set background=dark
set t_Co=256

"" Custom highlighting
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

"" Toggle *conceallevel*
nnoremap <Leader>co :let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>

" Text wrapping
set textwidth=80
set formatoptions-=l
set wrap linebreak nolist

"" Custom colors
hi CocCodeLens guifg=#40505E

"" Set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

highlight clear SignColumn
set autoread
au FocusGained * :checktime


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
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'SirVer/ultisnips'
  Plug 'Yggdroot/indentLine'

  " Autocomplete
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

  " Git
  Plug 'tpope/vim-fugitive'

  " NERDTree - File explorer
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Marks
  Plug 'kshenoy/vim-signature'

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
  "" Installs a bunch of languages
  Plug 'sheerun/vim-polyglot'

  " Themes
  Plug '~/code/personal/night-owl'
call plug#end()


"------------------------------------------------------------
" Plugin settings {{{1
"
"" Fugitive (tpope/vim-fugitive)
nmap <silent> :gss :G<CR>
nmap <silent> :Gss :G<CR>

"" EasyMotion (easymotion/vim-easymotion)
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfjö'
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

"" UltiSnips
let g:UltiSnipsSnippetsDir='~/.dotfiles/snippets'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/snippets']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'

"" NERDTree (SirVer/ultisnips)
set wildignore+=*.bs.js

let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeAutoDeleteBuffer = 1

"" RSpec mappings (thoughtbot/vim-rspec)
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nmap <silent> :ne :NERDTree<CR>
nmap <silent> :nc :NERDTreeCWD<CR>
nmap <silent> :ntf :NERDTreeFind<CR>
nmap <silent> :nq :NERDTreeClose<CR>

"" Rainbow brackets (luochen1990/rainbow)
let g:rainbow_active = 1

let g:rainbow_conf = {
\	'guifgs': ['gold', 'orchid', 'lightskyblue'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan'],
\}

"" YATS Typescript (sheerun/vim-polylot)
let g:yats_host_keyword = 1

function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

command! -nargs=0 Syn call Syn()

"" Set theme (personal/night-owl)
colorscheme night-owl


"------------------------------------------------------------
" CoC settings {{{1
"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> :tso :CocCommand editor.action.organizeImport<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

set hidden " if hidden is not set, TextEdit might fail.
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set cmdheight=1 " Better display for messages
set updatetime=300 " You will have a bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <M-TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-SPACE> coc#refresh()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


"------------------------------------------------------------
" Key mappings {{{1
"
"" Set leader key to spacebar
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let maplocalleader="\\"

"" Open file search with ;
map ; :Files<CR>


" Git diffs
"" Start by doing :Gdiff, from vim-fugitive, on a conflicted file
nnoremap <leader>gd :Gvdiff<CR>
"" Diffget from the left pane (merge branch)
nnoremap gdh :diffget //2<CR>
"" Diffget from right pane (target branch)
nnoremap gdl :diffget //3<CR>

"" Marks
nnoremap ' `

"" Remove arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"" Move between split panes
nnoremap <C-J> <C-W><C-J>	
nnoremap <C-K> <C-W><C-K>	
nnoremap <C-L> <C-W><C-L>	
nnoremap <C-H> <C-W><C-H>

"" Remove things I usally mistype
nnoremap q: <Nop>

"" Auto-expands for parens
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O


"------------------------------------------------------------
" Misc {{{1
"
" https://medium.com/@sidneyliebrand/vim-tip-persistent-undo-2fc78a2973a7
" Guard for distributions lacking the 'persistent_undo' feature.
if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif
