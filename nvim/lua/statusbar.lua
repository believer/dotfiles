local M = {}

local mode_map = {
	n = { label = "NORMAL", hl = "%#SLNormal#" },
	i = { label = "INSERT", hl = "%#SLInsert#" },
	v = { label = "VISUAL", hl = "%#SLVisual#" },
	V = { label = "V-LINE", hl = "%#SLVisual#" },
	["\22"] = { label = "V-BLOCK", hl = "%#SLVisual#" },
	R = { label = "REPLACE", hl = "%#SLReplace#" },
	c = { label = "COMMAND", hl = "%#SLCommand#" },
	t = { label = "TERMINAL", hl = "%#SLInsert#" },
}

local function mode_segment()
	local m = vim.api.nvim_get_mode().mode
	local info = mode_map[m] or { label = m:upper(), hl = "%#SLNormal#" }
	return info.hl .. " " .. info.label .. " "
end

local function filename_segment()
	local name = vim.fn.expand("%:t")
	if name == "" then
		name = "[No Name]"
	end
	local modified = vim.bo.modified and " ●" or ""
	return "%#SLMid# " .. name .. modified
end

local function branch_segment()
	local branch = vim.b.gitsigns_head
	if not branch or branch == "" then
		return ""
	end
	return "%#SLRight# " .. branch .. " | "
end

local function diagnostics_segment()
	local parts = {}
	local icons = {
		{ sev = "ERROR", icon = "󰅚", hl = "%#SLError#" },
		{ sev = "WARN", icon = "󰀪", hl = "%#SLWarn#" },
		{ sev = "INFO", icon = "󰋽", hl = "%#SLInfo#" },
		{ sev = "HINT", icon = "󰌶", hl = "%#SLHint#" },
	}

	for _, d in ipairs(icons) do
		local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[d.sev] })
		if n > 0 then
			parts[#parts + 1] = d.hl .. " " .. d.icon .. " " .. n
		end
	end

	if #parts == 0 then
		return ""
	end

	return table.concat(parts) .. " "
end

local function filetype_segment()
	local ft = vim.bo.filetype
	local t = ft == "" and "plain" or ft

	return "%#SLRight#" .. t .. " "
end

function _G.statusline()
	return table.concat({
		mode_segment(),
		filename_segment(),
		"%=", -- right-align separator
		diagnostics_segment(),
		branch_segment(),
		filetype_segment(),
	})
end

function M.setup()
	local function hl(name, fg_color, bg_color, b)
		local fg = fg_color == nil and "#1a1b26" or fg_color
		local bg = bg_color == nil and "#24283b" or bg_color
		local bold = b == nil and false or b

		vim.api.nvim_set_hl(0, name, { fg = fg, bg = bg, bold = bold })
	end

	-- Modes
	hl("SLNormal", nil, "#7aa2f7", true)
	hl("SLInsert", nil, "#9ece6a", true)
	hl("SLVisual", nil, "#bb9af7", true)
	hl("SLReplace", nil, "#f7768e", true)
	hl("SLCommand", nil, "#e0af68", true)

	-- Bar placement
	hl("SLMid", "#a9b1d6")
	hl("SLRight", "#a9b1d6", "#3b4161")

	-- Diagnostics
	hl("SLError", "#f7768e")
	hl("SLWarn", "#e0af68")
	hl("SLInfo", "#7dcfff")
	hl("SLHint", "#1abc9c")

	vim.opt.laststatus = 3 -- Global, no duplicates in splits
	vim.opt.statusline = "%!v:lua.statusline()"
end

return M
