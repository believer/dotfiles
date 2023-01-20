-- Automatically add matching parens, braces, quotes etc.
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true,
	},
}
