unmap <Space>

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

exmap focusRight obcommand editor:focus-right
nmap <C-l> :focusRight

exmap focusLeft obcommand editor:focus-left
nmap <C-h> :focusLeft

exmap back obcommand app:go-back
nmap <C-o> :back

exmap forward obcommand app:go-forward
nmap <C-i> :forward

exmap follow obcommand editor:follow-link
nmap gf :follow

exmap split obcommand editor:open-link-in-new-split
nmap gV :split

exmap switcher obcommand switcher:open
nmap <Space>; :switcher

exmap daily obcommand daily-notes
nmap gd :daily

exmap dailyPrevious obcommand daily-notes:goto-prev
nmap gp :dailyPrevious

exmap dailyNext obcommand daily-notes:goto-next
nmap gn :dailyNext

exmap template obcommand insert-template
nmap tt :template

exmap leftSidebar obcommand app:toggle-left-sidebar
nmap <Space>d :leftSidebar

exmap rightSidebar obcommand app:toggle-right-sidebar
nmap <Space>r :rightSidebar

exmap moveFile obcommand file-explorer:move-file
nmap mv :moveFile

exmap renameFile obcommand workspace:edit-file-title
nmap rn :renameFile

exmap showFile obcommand file-explorer:reveal-active-file
nmap <Space>f :showFile

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

