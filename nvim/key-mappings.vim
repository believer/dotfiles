"------------------------------------------------------------
" Key mappings {{{1
"
"" Set leader key to spacebar
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let maplocalleader="\\"

"" Fzf
nnoremap <silent> <leader>; :GFiles --cached --others --exclude-standard<CR>
nmap <leader>o :Buffers<CR>
nmap cc :Commands<CR>
nmap ?? :Rg 

" Git diffs
"" Start by doing :Gdiff, from vim-fugitive, on a conflicted file
nnoremap <leader>gd :Gvdiff<CR>
"" Diffget from the left pane (merge branch)
nnoremap gdl :diffget //2<CR>
"" Diffget from right pane (target branch)
nnoremap gdr :diffget //3<CR>

"" Git push
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>up :!git up<CR>

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

"" Remap things I usually mistype
nnoremap q: <Nop>
noremap :W :w

"" Auto-expands for parens
inoremap (; (<CR>)<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>}<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>]<C-c>O
inoremap [, [<CR>],<C-c>O

" CtrlSF
"" Do search/replace on the word under the cursor
nmap <leader>c :%s/\<<C-r><C-w>\>/<C-r><C-w>/gi<Left><Left><Left>
nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>

" Yank to clipboard
vnoremap <leader>y "*y

" NERDTree
"" Toggle drawer
noremap <leader>d :NERDTreeToggle<CR>

"" Open current file in drawer
noremap <leader>f :NERDTreeFind<CR>

nnoremap <leader>b :Bdelete hidden<CR>

" Remove HTML attribute
" diw - Delete inside word to be anywhere in attribute name
" x - Remove =
" da" - Remove attribute value
nnoremap <leader>ad diwxda"<Cr>

" Add shortcut to the black hole register
map <leader>r "_

" Logically scrolling
" Scroll up/down and center cursor
" https://twitter.com/ThePrimeagen/status/1591996471951429633
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Next search term and center cursor
nnoremap n nzz
