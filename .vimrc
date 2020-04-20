" Plugins
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
  Plug 'jiangmiao/auto-pairs'

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
  Plug 'scrooloose/nerdcommenter'
  
  " Formatters
  " Ruby
  Plug 'ruby-formatter/rufo-vim'

  " Syntax
  Plug 'gerw/vim-HiLinkTrace'
  Plug 'luochen1990/rainbow'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'thosakwe/vim-flutter'
  "" Installs a bunch of languages
  Plug 'sheerun/vim-polyglot'

  " Themes
  Plug '~/code/personal/night-owl'
call plug#end()

" JSON
let g:vim_json_syntax_conceal = 0

" Rust
let g:rustfmt_autosave = 1
let g:rufo_auto_formatting = 1

" Auto pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''"}

"" YATS
let g:yats_host_keyword = 1

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
nmap <silent> :tso :CocCommand editor.action.organizeImport<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Fugitive (Git)
nmap <silent> :gss :G<CR>
nmap <silent> :Gss :G<CR>

" EasyMotion
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfjö'
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Merginal
let g:merginal_windowWidth = '100'

" UltiSnips
let g:UltiSnipsSnippetsDir='~/.dotfiles/snippets'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/snippets']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'

" NERDTree
set wildignore+=*.bs.js

let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeAutoDeleteBuffer = 1

nnoremap <silent> <Leader>nt :NERDTree<CR>
nnoremap <silent> <Leader>nc :NERDTreeCWD<CR>
nnoremap <silent> <Leader>ntf :NERDTreeFind<CR>

" Editor
set foldmethod=syntax
set foldlevelstart=99
set laststatus=2
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set background=dark
set termguicolors
syntax enable
colorscheme night-owl
set t_Co=256

"" Toggle *conceallevel*
nnoremap <Leader>co :let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>

" Text wrapping
set textwidth=80
set formatoptions-=l
set wrap linebreak nolist

"" Custom colors
hi CocCodeLens guifg=#40505E

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

" Remaps
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let maplocalleader="\\"
map ; :Files<CR>
nnoremap q: <Nop>

" Git diffs
" Start by doing :Gdiff, from vim-fugitive, on a conflicted file
nnoremap <leader>gd :Gvdiff<CR>
" Diffget from the left pane (merge branch)
nnoremap gdh :diffget //2<CR>
"" Diffget from right pane (target branch)
nnoremap gdl :diffget //3<CR>

" Marks
nnoremap ' `

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

" https://medium.com/@sidneyliebrand/vim-tip-persistent-undo-2fc78a2973a7
" guard for distributions lacking the 'persistent_undo' feature.
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
