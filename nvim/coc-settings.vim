"------------------------------------------------------------
" CoC settings {{{1
"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> :tso :CocCommand editor.action.organizeImport<CR>
nmap <silent> :cco :CocCommand workspace.showOutput<CR>

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-SPACE> coc#refresh()

" Use <cr> to code complete.
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Highlight symbol under cursor on CursorHold
augroup coc
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

augroup rescript
  autocmd!
  autocmd FileType rescript nnoremap <silent> <buffer> K :RescriptTypeHint<CR>
  autocmd FileType rescript nnoremap <silent> <buffer> gd :RescriptJumpToDefinition<CR>
augroup END

" Code actions
xmap <leader>i <Plug>(coc-codeaction-line)
nmap <leader>i <Plug>(coc-codeaction-line)

nmap <leader>s :CocCommand document.toggleInlayHint<CR>
