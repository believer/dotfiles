local utils = require("utils")

local o = vim.opt
local g = vim.g
local map = vim.keymap.set
local gh = utils.gh

-- Install plugins
vim.pack.add({
	gh("folke/tokyonight.nvim"), -- Color scheme
	gh("folke/todo-comments.nvim"), -- Comment highlighting
	gh("tpope/vim-surround"), -- Actions on surrounding context
	gh("tpope/vim-fugitive"), -- Git
	gh("stevearc/oil.nvim"), -- File explorer
	gh("nvim-tree/nvim-web-devicons"), -- Icons in file explorer
	gh("stevearc/conform.nvim"), -- Formatter
	gh("lewis6991/gitsigns.nvim"), -- Git signs in gutter
	gh("nvim-mini/mini.nvim"), -- Mini pickers
	gh("L3MON4D3/LuaSnip"), -- Snippets
	gh("neovim/nvim-lspconfig"), -- LSP configs
	gh("mason-org/mason.nvim"), -- LSP installer
	gh("windwp/nvim-ts-autotag"), -- Automatically close/update HTML tags
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" }, -- Treesitter
	{ src = gh("saghen/blink.cmp"), version = "v1" }, -- Completions
})

-- Postinstall hooks
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind, cwd = ev.data.spec.name, ev.data.kind, ev.data.path

		if name == "luasnip" then
			vim.system({ "make", "install_jsregexp" }, { cwd = cwd })
		end

		if name == "mason" then
			vim.cmd("MasonUpdate")
		end

		if name == "nvim-treesitter" then
			vim.system({ "make" }, { cwd = cwd })
		end

		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end

		if name == "blink.cmp" then
			vim.system({ "cargo", "build", "--release" }, { cwd = cwd })
		end
	end,
})

-- Setup plugins
--------------------------------------------------

-- Treesitter
require("nvim-treesitter").setup({
	autopairs = { enable = true },
	indent = { enable = true },
	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},
	-- Enable windwp/nvim-ts-autotag for close/update tags
	autotag = { enable = true },
})

-- Install parsers
local ensureInstalled = {
	"css",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"rust",
	"scss",
	"templ",
	"typescript",
}

-- Only install parsers that aren't already installed
local tsInstalled = require("nvim-treesitter.config").get_installed()
local parsers = vim.iter(ensureInstalled)
	:filter(function(parser)
		return not vim.tbl_contains(tsInstalled, parser)
	end)
	:totable()

require("nvim-treesitter").install(parsers)

-- Start Treesitter
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

--- LSP
--- Display diagnostic messages inline
vim.diagnostic.config({
	virtual_text = { current_line = true },
})

require("mason").setup()

local settingsJsTs = {
	inlayHints = {
		includeInlayEnumMemberValueHints = true,
		includeInlayFunctionLikeReturnTypeHints = true,
		includeInlayFunctionParameterTypeHints = true,
		includeInlayParameterNameHints = "all",
		includeInlayParameterNameHintsWhenArgumentMatchesName = true,
		includeInlayPropertyDeclarationTypeHints = true,
		includeInlayVariableTypeHints = false,
	},
}

vim.lsp.config.ts_ls = {
	completion = {
		completeFunctionCalls = true,
	},
	init_options = {
		preferences = {
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
			importModuleSpecifierPreference = "non-relative",
			importModuleSpecifierEnding = "minimal",
		},
	},
	settings = {
		javascript = settingsJsTs,
		typescript = settingsJsTs,
	},
}

vim.lsp.config.tailwindcss = {
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
			includeLanguages = {
				templ = "html",
			},
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			experimental = {
				-- Support tailwind-variants
				classRegex = {
					{ "tv\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				},
			},
			validate = true,
		},
	},
}

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

vim.lsp.config.yamlls = {
	settings = {
		yaml = {
			format = {
				enable = true,
			},
			schemas = {
				["https://raw.githubusercontent.com/nexlabstudio/maestro-workbench/refs/heads/dev/schema/schema.v0.json"] = "/apps/blackbird/.maestro/**/*",
				["https://www.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
}

vim.lsp.enable({
	"biome",
	"cssls",
	"gopls",
	"jsonls",
	"lua_ls",
	"prettierd",
	"stylua",
	"tailwindcss",
	"templ",
	"ts_ls",
	"yamlfmt",
	"yamlls",
})

-- Luasnip
local ls = require("luasnip")

ls.setup({
	enable_autosnippets = true,
})

require("luasnip.loaders.from_lua").load({
	paths = "~/.dotfiles/nvim/lua/snippets",
})

map("i", "<C-e>", function()
	ls.expand_or_jump(1)
end, { silent = true })
map({ "i", "s" }, "<C-J>", function()
	ls.jump(1)
end, { silent = true })
map({ "i", "s" }, "<C-K>", function()
	ls.jump(-1)
end, { silent = true })

-- Blink
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

-- Hide certain files in file explorer
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

local js_types = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

for _, type in ipairs(js_types) do
	formatter_settings.formatters_by_ft[type] = { "biome-check" }
end

require("conform").setup(formatter_settings)

-- Color scheme
vim.cmd.colorscheme("tokyonight-night")

-- Custom status bar (must run after color scheme)
require("statusbar").setup()

-- Basic settings
--------------------------------------------------

-- Enable Neovim 0.12 features
vim.cmd.packadd("nvim.undotree") -- Undo tree

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

-- Packages
map("n", "<leader>pu", vim.pack.update)

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

-- Add code action commands
local autocommands = {
	ts_commands = {
		pattern = js_types,
		triggers = { "FileType" },
		callback = function()
			local commands = {
				{ name = "TSRemoveUnused", source = "source.removeUnused.ts" },
				{ name = "TSAddImports", source = "source.addMissingImports.ts" },
				{ name = "TSOrganizeImports", source = "source.organizeImports.ts" },
			}

			for _, c in ipairs(commands) do
				vim.api.nvim_create_user_command(c.name, function()
					vim.lsp.buf.code_action({
						apply = true,
						context = {
							only = { c.source },
							diagnostics = {},
						},
					})
				end, {})
			end
		end,
	},
}

utils.add_autocommands(autocommands)
