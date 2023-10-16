" Unmap space to use as leader key
unmap <Space>

" Move by visual lines
nmap j gj
nmap k gk

" Editor
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

exmap leftSidebar obcommand app:toggle-left-sidebar
nmap <Space>d :leftSidebar

exmap rightSidebar obcommand app:toggle-right-sidebar
nmap <Space>r :rightSidebar

exmap backlinks obcommand backlink:toggle-backlinks-in-document
nmap <Space>b :backlinks

" Daily
exmap daily obcommand daily-notes
nmap gd :daily

exmap dailyPrevious obcommand daily-notes:goto-prev
nmap gp :dailyPrevious

exmap dailyNext obcommand daily-notes:goto-next
nmap gn :dailyNext

" File handling
exmap template obcommand insert-template
nmap tt :template

exmap moveFile obcommand file-explorer:move-file
nmap mv :moveFile

exmap renameFile obcommand workspace:edit-file-title
nmap rn :renameFile

exmap showFile obcommand file-explorer:reveal-active-file
nmap <Space>f :showFile

exmap showFileProperties obcommand properties:open-local
nmap <Space>p :showFileProperties

" Surround strings like vim-surround
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

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
