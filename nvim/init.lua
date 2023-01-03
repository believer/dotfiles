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
require('lualine').setup {
  options = {
    theme = 'tokyonight',
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
vim.cmd('colorscheme tokyonight-night')

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
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  view = {
    side = 'right',
  },
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
vim.keymap.set('n', '<leader>gp', ':Git push<cr>', {})
vim.keymap.set('n', '<leader>up', ':!git up<cr>', {})
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

-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
}

vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})

-- Git signs
require('gitsigns').setup()
