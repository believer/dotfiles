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

"" Fern.vim
let g:fern#disable_default_mappings = 1
let g:fern#smart_cursor = "hide"

" Fern setup
" https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html#fernvim
function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> D <Plug>(fern-action-new-dir)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> <nowait> h <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

"" RSpec mappings (thoughtbot/vim-rspec)
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>

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

"" FastFold
set sessionoptions-=folds

let g:markdown_folding = 1
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:ruby_fold = 1
let g:rust_fold = 1

"" Open today's note of Logseq
function! OpenToday()
    let today = strftime('%Y-%m-%d')
    let todays_journal = today . ".md"

    execute "e ~/Dropbox/Dokument/Obsidian/Rickard/" . todays_journal
endfunction

nmap <Leader>ww :call OpenToday()<CR>
