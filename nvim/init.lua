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

require("settings")
require("lazy").setup("plugins", {
	checker = {
		enabled = true,
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
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
}

add_autocommands(autocommands)
