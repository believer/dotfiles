return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",

		-- UI for completion menu
		"NvChad/ui",

		-- Snippet support
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
	event = "InsertEnter",
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		-- Add borders to completion menu
		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		-- Configure completion menu
		vim.o.completeopt = "menu,menuone,noselect"

		-- Remove scrollbars from completion menu
		local cmp_window = require("cmp.utils.window")

		cmp_window.info_ = cmp_window.info
		cmp_window.info = function(self)
			local info = self:info_()
			info.scrollable = false
			return info
		end

		cmp.setup({
			-- Add borders to completion menu
			window = {
				completion = {
					border = border("Comment"),
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
				},
				documentation = {
					border = border("Comment"),
				},
			},

			-- Snippet expansions from Luasnip
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- Add icons to completion menu
			formatting = {
				format = function(entry, vim_item)
					local icons = require("nvchad_ui.icons").lspkind
					vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
					vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
					return vim_item
				end,
			},

			-- Key mappings to navigate completion menu
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.close(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- Add additional completion sources
			sources = cmp.config.sources({
				{ name = "luasnip", priority = 10 }, -- Snippets
				{ name = "nvim_lsp", priority = 5 }, -- LSP
				{ name = "path", max_item_count = 5, priority = 3 }, -- File paths
			}, {
				{ name = "spell", max_item_count = 5, priority = 2 }, -- Spelling
				{ name = "buffer", max_item_count = 5, keyword_length = 3, priority = 1 }, -- Texts from buffer
			}),
		})

		-- Add parenthesis when completing methods
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
