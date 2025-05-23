local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Floating todo window
require("floatingtodo").setup({
	target_file = "~/code/Rickard/TODO.md",
})

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
require("snippets")

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
