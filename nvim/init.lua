require('settings')
require('plugins')
require('lsp')
require('snippets')

local map = require('utils').map

-- Color scheme
vim.cmd('colorscheme tokyonight-night')

-- Git
map('n', '<leader>gp', ':Git push<cr>')
map('n', '<leader>up', ':!git up<cr>')
map('n', ':gss', ':G<cr>')

-- Highlights the text that I'm yanking
-- Courtesy of TJ DeVries
-- https://youtu.be/apyV4v7x33o?t=2912
vim.cmd([[
augroup yanking
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
augroup END
]])
