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

"" Make commands ignore casing
set ignorecase
set smartcase

"" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType markdown setlocal spell spelllang=en_gb

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

" Text wrapping
set textwidth=80
set formatoptions-=l
set wrap linebreak nolist

" Display things that will change from a substitute command
set inccommand=split

"" Custom colors
hi CocCodeLens guifg=#40505E

"" Set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

highlight clear SignColumn
set autoread
au FocusGained * :checktime

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Highlights the text that I'm yanking
" Courtesy of TJ DeVries
" https://youtu.be/apyV4v7x33o?t=2912
au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
