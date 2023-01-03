require('plugins')

-- Leader
vim.keymap.set('n', '<Space>', '<Nop>', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'


-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- Always display the sign column (where errors are displayed)
vim.opt.signcolumn = 'yes'
vim.cmd('highlight clear SignColumn') -- Remove highlighting of sign column

-- Split new buffers to the right
vim.opt.splitright = true

-- Make : commands ignore casing
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Lualine setup
local colors = {
  black   = '#051626',
  lightgrey = '#282C34',
  grey = '#334452',
  red    = '#EF5350',
  green = '#22DA63',
  forest = '#ADDB67',
  yellow = '#FFEB95',
  blue = '#82AAFF',
  violet = '#C792EA',
  cyan = '#7fdbca',
  lightcyan = '#68B0A0',
  white  = '#c6c6c6',
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.cyan },
    b = { fg = colors.black, bg = colors.lightcyan },
    c = { fg = colors.cyan, bg = colors.lightgrey },
  },
  insert = {
    a = { fg = colors.black, bg = colors.forest },
    c = { fg = colors.forest, bg = colors.lightgrey },
  },
  visual = { 
    a = { fg = colors.black, bg = colors.blue },
    c = { fg = colors.blue, bg = colors.lightgrey },
  },
  replace = { a = { fg = colors.black, bg = colors.red } },
}

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'branch' },
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { 'encoding', 'location' },
  }
}

-- Line numbers and relative numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.tabstop = 2 -- 1 tab = 2 spaces
vim.opt.shiftwidth = 2 -- indentation
vim.opt.autoindent = true
vim.opt.expandtab = true -- expand tabs to spaces
vim.opt.smartindent = true

-- Color scheme
vim.cmd('colorscheme night-owl')

-- Telescope setup
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>;', telescope.find_files, {})
vim.keymap.set('n', '??', telescope.live_grep, {})
vim.keymap.set('n', '<leader>o', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

-- Nvim Tree
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup{
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false
      }
    }
  }
}

vim.keymap.set('n', '<leader>d', ':NvimTreeToggle<cr>', {})

-- Move between panes
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', {})
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', {})
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', {})
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', {})

-- Git
vim.keymap.set('n', '<leader>gp', ':Git push', {})
vim.keymap.set('n', '<leader>up', ':!git up', {})
vim.keymap.set('n', ':gss', ':G<cr>', { silent = true })

-- Highlights the text that I'm yanking
-- Courtesy of TJ DeVries
-- https://youtu.be/apyV4v7x33o?t=2912
vim.cmd([[
augroup yanking
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
augroup END
]])

-- LSP setup
require('mason').setup()
require('mason-lspconfig').setup()

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Load TS LSP
require('lspconfig').tsserver.setup {
  capabilities = capabilities
}

local bufopts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

