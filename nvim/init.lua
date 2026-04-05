local utils = require("utils")

local function gh(n)
	return "https://github.com/" .. n
end

-- Install plugins
vim.pack.add({
	gh("folke/tokyonight.nvim"), -- Color scheme
	gh("nvim-lua/plenary.nvim"), -- Dependency for todo-comments
	gh("folke/todo-comments.nvim"), -- Comment highlighting
	gh("nvim-lualine/lualine.nvim"), -- Status line
	gh("tpope/vim-surround"), -- Actions on surrounding context
	gh("tpope/vim-fugitive"), -- Git
	gh("stevearc/oil.nvim"), -- File explorer
	gh("nvim-tree/nvim-web-devicons"), -- Icons in file explorer
	gh("stevearc/conform.nvim"), -- Formatter
	gh("lewis6991/gitsigns.nvim"), -- Git signs in gutter
	gh("nvim-mini/mini.nvim"), -- Mini pickers
	{ src = gh("saghen/blink.cmp"), version = "v1" }, -- Completions
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "blink.cmp" then
			vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
		end
	end,
})

-- Setup plugins
--------------------------------------------------

require("blink.cmp").setup({
	completion = {
		documentation = {
			auto_show = true,
		},
		ghost_text = {
			enabled = false,
		},
		menu = {
			auto_show = function(ctx)
				return ctx.mode ~= "cmdline"
			end,
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
			},
		},

		accept = {
			auto_brackets = {
				semantic_token_resolution = {
					blocked_filetypes = { "typescriptreact" },
				},
			},
		},
	},

	keymap = {
		preset = "default",
		["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
		["S-<Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		["<CR>"] = { "select_and_accept", "fallback" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
})

-- Lualine
require("lualine").setup({
	options = {
		theme = "tokyonight",
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = { "branch", "diagnostics" },
		lualine_x = {},
		lualine_y = { "filetype" },
		lualine_z = {},
	},
})

-- TODO Comments
require("todo-comments").setup()

-- Mini
require("mini.extra").setup()
require("mini.pairs").setup()
require("mini.pick").setup()

local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	footer = "", -- Show nothing after, nil displays help
	items = {
		starter.sections.pick(),
		starter.sections.recent_files(10, true, false),
	},
	content_hooks = {
		starter.gen_hook.aligning("center", "center"),
		starter.gen_hook.indexing("all"),
	},
})

-- Oil
local oil = require("oil")

oil.setup({
	keymaps = {
		["<C-v>"] = "actions.select_vsplit",
		["<C-x>"] = "actions.select_split",
		["<C-h>"] = false, -- Original select_split
		["<C-l>"] = false, -- Original refresh
		["<C-r>"] = "actions.refresh",
	},
})

oil.set_is_hidden_file(function(name)
	return name:match("^%.") ~= nil or vim.endswith(name, "_templ.go")
end)

-- Conform
local formatter_settings = {
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		css = { "biome-check" },
		-- Enable formatting of embedded languages using injected
		-- For example, sql from queries/go/injections.scm
		go = { "gofmt", "injected" },
		json = { "biome-check" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		ruby = { "rubyfmt" },
		rust = { "rustfmt" },
		sql = { "pg_format" },
		yaml = { "yamlfmt" },
	},
}

local js_types = require("filetypes").js

for _, type in ipairs(js_types) do
	formatter_settings.formatters_by_ft[type] = { "biome-check" }
end

require("conform").setup(formatter_settings)

-- Basic settings
--------------------------------------------------

vim.cmd.colorscheme("tokyonight-night")

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
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99

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

map("v", "<leader>y", '"+y') -- Copy to system clipboard

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
map("n", "<leader>ar", ":TSRemoveUnused<CR>")
map("n", "<leader>at", ":TSOrganizeImports<CR>")
map("n", "<leader>ai", ":TSAddImports<CR>")

-- LSP
map("n", "gd", vim.lsp.buf.definition) -- Go to definition
map("n", "gD", vim.lsp.buf.declaration) -- Go to declaration
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

utils.add_autocommands(autocommands)
