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
	return "%#SLRight# " .. branch
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

	return "%#SLRight# | " .. t .. " "
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
	local fg = "#1a1b26"
	local bg = "#24283b"
	local blue = "#7aa2f7"
	local red = "#f7768e"

	vim.api.nvim_set_hl(0, "SLNormal", { fg = fg, bg = blue, bold = true })
	vim.api.nvim_set_hl(0, "SLInsert", { fg = fg, bg = "#9ece6a", bold = true })
	vim.api.nvim_set_hl(0, "SLVisual", { fg = fg, bg = "#bb9af7", bold = true })
	vim.api.nvim_set_hl(0, "SLReplace", { fg = fg, bg = red, bold = true })
	vim.api.nvim_set_hl(0, "SLCommand", { fg = fg, bg = "#e0af68", bold = true })
	vim.api.nvim_set_hl(0, "SLMid", { fg = "#a9b1d6", bg = bg })
	vim.api.nvim_set_hl(0, "SLRight", { fg = "#a2a8c6", bg = "#3b4161" })
	vim.api.nvim_set_hl(0, "SLError", { fg = red, bg = bg })
	vim.api.nvim_set_hl(0, "SLWarn", { fg = "#e0af68", bg = bg })
	vim.api.nvim_set_hl(0, "SLInfo", { fg = "#7dcfff", bg = bg })
	vim.api.nvim_set_hl(0, "SLHint", { fg = "#1abc9c", bg = bg })

	vim.opt.laststatus = 3 -- Global, no duplicates in splits
	vim.opt.statusline = "%!v:lua.statusline()"
end

return M
