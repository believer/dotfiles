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

"" UltiSnips / coc-snippets
let g:UltiSnipsSnippetsDir='~/.dotfiles/coc/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/coc/ultisnips']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"" NERDTree
let g:NERDTreeMinimalMenu=1 " Temporary fix for m-menu https://github.com/preservim/nerdtree/issues/1321
let g:NERDTreeWinPos = "right"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeQuitOnOpen = 1 " Quit NERDTree when opening a file

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

"" Gutentags cache
let g:gutentags_cache_dir = $HOME.'/.ctags.d/cache'

"" Startify
let g:startify_change_to_dir = 0 " Keep CWD when using actions

"" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"" Open today's note of Logseq
function! OpenToday()
    let today = strftime('%Y-%m-%d')
    let todays_journal = today . ".md"

    execute "e ~/Dropbox/Dokument/Obsidian/Rickard/Daily Notes/" . todays_journal
endfunction

nmap <Leader>ww :call OpenToday()<CR>

" Autopairs
let g:AutoPairsFlyMode = 1

" Vim info for vim-startify
set viminfo='100,n$HOME/.vim/files/info/viminfo

" FastFold
let g:javaScript_fold = 1
let g:markdown_folding = 1
