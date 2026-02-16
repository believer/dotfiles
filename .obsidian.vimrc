" Unmap space to use as leader key
unmap <Space>

" Move by visual lines
nmap j gj
nmap k gk

" Editor
exmap focusRight obcommand editor:focus-right
nmap <C-l> :focusRight<CR>

exmap focusLeft obcommand editor:focus-left
nmap <C-h> :focusLeft<CR>

exmap back obcommand app:go-back
nmap <C-o> :back<CR>

exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

exmap follow obcommand editor:follow-link
nmap gf :follow<CR>

exmap split obcommand editor:open-link-in-new-split
nmap gV :split<CR>

exmap switcher obcommand switcher:open
nmap <Space>; :switcher<CR>

exmap leftSidebar obcommand app:toggle-left-sidebar
nmap <Space>d :leftSidebar<CR>

exmap rightSidebar obcommand app:toggle-right-sidebar
nmap <Space>r :rightSidebar<CR>

" Daily
exmap daily obcommand daily-notes
nmap gd :daily<CR>

exmap dailyPrevious obcommand daily-notes:goto-prev
nmap gp :dailyPrevious<CR>

exmap dailyNext obcommand daily-notes:goto-next
nmap gn :dailyNext<CR>

" File handling
exmap template obcommand insert-template
nmap tt :template<CR>

exmap moveFile obcommand file-explorer:move-file
nmap mv :moveFile<CR>

exmap renameFile obcommand workspace:edit-file-title
nmap rn :renameFile<CR>

exmap showFile obcommand file-explorer:reveal-active-file
nmap <Space>f :showFile<CR>


