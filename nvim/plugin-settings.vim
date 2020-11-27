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
