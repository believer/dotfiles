local map = require("utils").map
local g = vim.g
local o = vim.opt

-- Leader
g.mapleader = " "
g.maplocalleader = " "

-- Define Python path
g.python3_host_prog = "/usr/bin/python3"

-- set termguicolors to enable highlight groups
o.termguicolors = true

-- Always display the sign column (where errors are displayed)
o.signcolumn = "yes"
vim.cmd("highlight clear SignColumn") -- Remove highlighting of sign column

-- Split new buffers to the right
o.splitright = true

-- Make : commands ignore casing
o.ignorecase = true
o.smartcase = true

-- Search
o.hlsearch = false
o.incsearch = true

-- Display line numbers and use relative numbering
o.number = true
o.relativenumber = true

-- Tabs
o.tabstop = 2 -- 1 tab = 2 spaces
o.shiftwidth = 2 -- indentation
o.autoindent = true
o.expandtab = true -- expand tabs to spaces
o.smartindent = true

-- Simplify moving between panes
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")

-- Persist undos after buffers are unloaded
o.undofile = true

-- Copy to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Keep cursor position when collapsing lines
map("n", "J", "mzJ`z")

-- Center cursor when scrolling up and down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Center search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Remove arrow keys
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")

-- Remap things I usually mistype
map("n", "q:", "<Nop>")
map("n", ":W", vim.cmd.w)

-- Remove HTML attribute
-- diw - Delete inside word to be anywhere in attribute name
-- x - Remove =
-- da" - Remove attribute value
map("n", "<leader>ad", "diwxda<cr>")

-- Shortcut to the black hole register
map("n", "<leader>r", '"_')

-- Tell GitHub Copilot to use Node 16
g.copilot_node_command = "~/Library/Caches/fnm_multishells/20517_1672831454977/bin/node"

-- Map Copilot completion to ctrl + j
-- replace_keycodes = false fixes an issue where Copilot would insert weird characters
-- https://github.com/community/community/discussions/29817#discussioncomment-4217615
g.copilot_no_tab_map = true
map("i", "<C-j>", 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true, replace_keycodes = false })
