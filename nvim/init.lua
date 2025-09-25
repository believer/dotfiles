local o = vim.opt
local g = vim.g
local map = vim.keymap.set

-- Basics
o.number = true -- Line numbers
o.relativenumber = true -- Relative line numbers
o.linebreak = true -- Wrap long lines with full words
o.scrolloff = 10 -- Keep 10 lines above/below cursor
o.splitright = true -- Split new buffers to the right

-- Indentation
o.tabstop = 2 -- 1 tab = 2 spaces
o.shiftwidth = 2 -- Indentation width
o.autoindent = true -- Copy indent from current line
o.expandtab = true -- Use spaces instead of tabs
o.smartindent = true -- Smart auto-indenting

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

-- Visual settings
o.termguicolors = true -- Enable highlight groups
o.signcolumn = "yes" -- Always display the sign column (where errors are displayed)
o.showcmd = false -- Hide partial commands in status bar

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

-- Highlight on yank
-- Taken from kickstart.nvim
local autocommands = {
	highlight_yank = {
		group_opts = { clear = true },
		triggers = { "TextYankPost" },
		callback = function()
			vim.highlight.on_yank()
		end,
	},
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
