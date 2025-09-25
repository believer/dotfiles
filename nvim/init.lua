local utils = require("utils")

local o = vim.opt
local g = vim.g
local map = vim.keymap.set

-- Basics
o.number = true -- Line numbers
o.relativenumber = true -- Relative line numbers
o.linebreak = true -- Wrap long lines with full words
o.scrolloff = 10 -- Keep 10 lines above/below cursor
o.splitright = true -- Split new buffers to the right
o.iskeyword:remove("-") -- Treat dash as word separator
o.spelllang = { "en", "sv" } -- Spell check English and Swedish

-- Indentation
o.tabstop = 2 -- 1 tab = 2 spaces
o.shiftwidth = 2 -- Indentation width
o.autoindent = true -- Copy indent from current line
o.expandtab = true -- Use spaces instead of tabs
o.smartindent = true -- Smart auto-indenting

-- Search
o.ignorecase = true -- Case insensitive search
o.smartcase = true -- Case sensitive search when using capital characters
o.hlsearch = false -- Don't highlight search results
o.incsearch = true -- Show matches as you type

-- Visual
o.termguicolors = true -- Enable highlight groups
o.signcolumn = "yes" -- Always display the sign column (where errors are displayed)
o.showcmd = false -- Hide partial commands in status bar
o.winborder = "rounded" -- Windows, like hover or completion, have 1px solid rounded border

vim.cmd("highlight clear SignColumn") -- Remove highlighting of sign column

-- Backups
o.swapfile = false
o.undofile = true -- Persist undos after buffers are unloaded

-- Key mappings
g.mapleader = " "
g.maplocalleader = " "

map("n", "<leader>y", '"+y') -- Copy to system clipboard

-- Simplify moving between panes
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")

-- Center cursor when scrolling up and down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Files / Searching
map("n", "-", ":Oil<CR>")
map("n", "<leader>;", ":Pick files<CR>") -- Files
map("n", "<leader>?", ":Pick grep_live<CR>") -- Search in files
map("n", "<leader>th", ":Pick help<CR>") -- Help files
map("n", "<leader>tr", ":Pick resume<CR>") -- Resume latest pick

-- Git
map("n", "<leader>gp", ":Git push<CR>")
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gu", ":!git up<CR>")
map("n", "<leader>gz", ":Gitsigns toggle_current_line_blame<CR>")
map("n", "<leader>gcb", ":Pick git_commits path='%'<CR>") -- Commits for current buffer
map("n", "<leader>gcc", ":Pick git_commits<CR>") -- Commits
map("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>")

-- Custom
map("n", "<leader>ad", 'diwxda"<CR>') -- Remove HTML attributes
map("n", "<leader>ar", ":TSRemoveUnused")
map("n", "<leader>at", ":TSOrganizeImports")
map("n", "<leader>ai", ":TSAddImports")

-- LSP
map("n", "gV", ":vert winc ]<CR>") -- Open definition in vertical split
map("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Spelling
map("n", "<leader>ww", function()
	vim.wo.spell = not vim.wo.spell
end)
map("n", "<leader>ws", function()
	utils.add_word_to_lang("sv")
end)
map("n", "<leader>we", function()
	utils.add_word_to_lang("en")
end)

-- Remap things I usually mistype
map("n", "q:", "<Nop>")
map("n", ":W", ":write<CR>")

-- Remove arrow keys
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.ngit",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
o.rtp:prepend(lazypath)

require("settings")
require("lazy").setup("plugins", {
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"bugreport",
				"compiler",
				"ftplugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"netrw",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"optwin",
				"rplugin",
				"rrhelper",
				"spellfile_plugin",
				"synmenu",
				"syntax",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
	change_detection = {
		notify = false,
	},
})

local add_autocommands = require("utils").add_autocommands

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

local autocommands = {
	ts_remove = {
		pattern = require("filetypes").js,
		triggers = { "FileType" },
		callback = function()
			-- Remove unused variables
			vim.api.nvim_create_user_command("TSRemoveUnused", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.removeUnused.ts" },
						diagnostics = {},
					},
				})
			end, {})

			-- Add missing imports
			vim.api.nvim_create_user_command("TSAddImports", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.addMissingImports.ts" },
						diagnostics = {},
					},
				})
			end, {})

			-- Automatically organize imports
			vim.api.nvim_create_user_command("TSOrganizeImports", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports.ts" },
						diagnostics = {},
					},
				})
			end, {})
		end,
	},
}

add_autocommands(autocommands)
