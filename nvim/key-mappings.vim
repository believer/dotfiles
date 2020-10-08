"------------------------------------------------------------
" Key mappings {{{1
"
"" Set leader key to spacebar
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let maplocalleader="\\"

"" Fzf
nmap ; :Files<CR>
nmap <leader>o :Buffers<CR>
nmap cc :Commands<CR>
nmap ?? :Rg<CR>

" Git diffs
"" Start by doing :Gdiff, from vim-fugitive, on a conflicted file
nnoremap <leader>gd :Gvdiff<CR>
"" Diffget from the left pane (merge branch)
nnoremap gdl :diffget //2<CR>
"" Diffget from right pane (target branch)
nnoremap gdr :diffget //3<CR>

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

" Fern.vim
"" Toggle drawer
noremap <leader>d :Fern . -drawer -width=35 -toggle<CR><C-w>=

"" Open current file in drawer
noremap <leader>f :Fern . -drawer -reveal=% -width=35<CR><C-w>=

"" Open current buffer's directory in drawer
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=

"" Close all buffers except the current
command BufOnly silent! execute "%bd|e#|bd#"

nnoremap <leader>b :BufOnly<CR>
