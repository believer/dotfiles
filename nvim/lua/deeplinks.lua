-- deeplink.lua
-- A minimal Neovim plugin for picking and opening app deeplinks via
-- `xcrun simctl openurl` (iOS Simulator).
--
-- Requires Neovim 0.10+ (uses vim.system).
--
-- Uses vim.ui.select for the picker by default, so it automatically shows
-- up in mini.pick if you've hooked it in, e.g.:
--   vim.ui.select = require("mini.pick").ui_select
-- When that hook is detected, the picker is driven natively through
-- mini.pick instead (same UI, but lets us dim the url/params column).
--
-- Installation (lazy.nvim example):
--   {
--     dir = "~/path/to/deeplink.lua",  -- or wherever you place this file
--     config = function()
--       require("deeplink").setup({
--         links = {
--           { name = "Home",    url = "myapp://home" },
--           { name = "Profile", url = "myapp://profile/123" },
--         },
--       })
--     end,
--   }
--
-- Usage:
--   :DeepLink              open picker, choose a link, opens on the booted simulator
--   :DeepLinkOpen <url>    open a specific url directly, e.g. :DeepLinkOpen myapp://home
--   :DeepLinkReload        re-scan the project-local links file (see below)
--
-- Project-local links:
--   Drop a `deeplinks.json` in your project root (cwd) like:
--     {
--       "bundleIdentifier": "se.seb.sebinvest.acc",
--       "links": [
--         { "name": "Markets", "url": "/markets" },
--         {
--           "name": "Account (Ava)",
--           "url": "/account/:id/:type/:name",
--           "params": {
--             "id": "01000263037",
--             "type": "isk",
--             "name": "Investeringssparkonto"
--           }
--         }
--       ]
--     }
--   Each link's "url" is just the path (leading "/" optional) — it's
--   combined with bundleIdentifier to form "<bundleIdentifier>://<path>".
--   "params" is optional; any ":name" segment in the url is substituted
--   with the matching param before opening. The picker shows the name,
--   the raw url template, and the params separately so you can see what
--   will be filled in. Links passed to setup() support the same
--   url/params shape. These are merged with (and appended after) the
--   links passed to setup().

local M = {}

M.config = {
	links = {},
	simulator = "booted", -- or a specific device UDID from `xcrun simctl list devices`
	project_file = "deeplinks.json",
	-- Highlight group used for the url/params portion of each picker row
	-- (only applied when the picker is driven natively via mini.pick).
	detail_hl = "Comment",
}

local project_links_cache = nil

local function load_project_links()
	local path = M.config.project_file
	local f = io.open(path, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()

	local ok, decoded = pcall(vim.json.decode, content)
	if not ok or type(decoded) ~= "table" then
		vim.notify("deeplink: failed to parse " .. path, vim.log.levels.WARN)
		return {}
	end

	local bundle_id = decoded.bundleIdentifier
	local raw_links = decoded.links or {}

	if not bundle_id then
		vim.notify("deeplink: " .. path .. ' is missing "bundleIdentifier"', vim.log.levels.WARN)
		return {}
	end

	local links = {}
	for _, link in ipairs(raw_links) do
		local link_path = (link.url or ""):gsub("^/", "")
		table.insert(links, {
			name = link.name,
			path = "/" .. link_path, -- store path without bundle id for display
			url = bundle_id .. "://" .. link_path,
			params = link.params,
		})
	end
	return links
end

local function apply_params(url_template, params)
	if not params then
		return url_template
	end
	local url = url_template
	for key, value in pairs(params) do
		-- %f[%W] is a frontier pattern: it matches the boundary right after
		-- the param name, so ":id" doesn't also swallow ":identifier".
		url = url:gsub(":" .. key .. "%f[%W]", tostring(value))
	end
	return url
end

local function format_params(params)
	if not params or next(params) == nil then
		return ""
	end
	local keys = {}
	for k in pairs(params) do
		table.insert(keys, k)
	end
	table.sort(keys)

	local parts = {}
	for _, k in ipairs(keys) do
		table.insert(parts, string.format("%s: %s", k, tostring(params[k])))
	end
	return table.concat(parts, "  ")
end

-- Turns a raw {name, url, params} link into a picker-ready item: the
-- fully-substituted url to open, plus a two-column display line (name,
-- then the raw template + params) with the column offset where the
-- "detail" portion starts, so it can be dimmed.
local function build_item(link, max_name_len, max_path_len)
	local name = link.name or ""
	-- Display path without bundle identifier (or default to raw url if no separate path)
	local display_url = link.path or link.url or ""
	local params_str = format_params(link.params)

	local padded_name = string.format("%-" .. max_name_len .. "s", name)
	local padded_url = string.format("%-" .. max_path_len .. "s", display_url)

	local prefix = padded_name .. "  "
	local url_col = padded_url .. "  "
	local text = prefix .. url_col .. params_str

	local url_start = #prefix
	local url_end = url_start + #padded_url

	return {
		name = link.name,
		url = apply_params(link.url, link.params),
		template = link.url,
		params = link.params,
		text = text,
		url_start_col = url_start,
		url_end_col = url_end,
	}
end

local function all_items()
	if project_links_cache == nil then
		project_links_cache = load_project_links()
	end
	local raw_links = {}
	vim.list_extend(raw_links, M.config.links)
	vim.list_extend(raw_links, project_links_cache)

	local max_name_len = 10
	local max_path_len = 10
	for _, link in ipairs(raw_links) do
		local display_url = link.path or link.url or ""
		max_name_len = math.max(max_name_len, #(link.name or ""))
		max_path_len = math.max(max_path_len, #display_url)
	end

	local items = {}
	for _, link in ipairs(raw_links) do
		table.insert(items, build_item(link, max_name_len, max_path_len))
	end
	return items
end

local function open_url(url)
	local cmd = { "xcrun", "simctl", "openurl", M.config.simulator, url }
	vim.system(cmd, { text = true }, function(res)
		vim.schedule(function()
			if res.code ~= 0 then
				vim.notify("deeplink: failed to open " .. url .. "\n" .. (res.stderr or ""), vim.log.levels.ERROR)
			else
				vim.notify("deeplink: opened " .. url, vim.log.levels.INFO)
			end
		end)
	end)
end

local function mini_pick_ui_select()
	local ok, mini_pick = pcall(require, "mini.pick")
	if ok and vim.ui.select == mini_pick.ui_select then
		return mini_pick
	end
	return nil
end

local function pick_with_mini(mini_pick, items)
	local ns = vim.api.nvim_create_namespace("deeplink_detail")

	mini_pick.start({
		source = {
			items = items,
			name = "Deeplinks",
			show = function(buf_id, items_arr, query, opts)
				mini_pick.default_show(buf_id, items_arr, query, opts)
				vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)
				for i, item in ipairs(items_arr) do
					if item.url_start_col and item.url_end_col then
						-- Highlight ONLY the URL field with the lighter/comment highlight group
						pcall(
							vim.api.nvim_buf_add_highlight,
							buf_id,
							ns,
							M.config.detail_hl,
							i - 1,
							item.url_start_col,
							item.url_end_col
						)
					end
				end
			end,
			choose = function(item)
				if item then
					open_url(item.url)
				end
			end,
		},
	})
end

local function pick_with_vim_ui(items)
	vim.ui.select(items, {
		prompt = "Open deeplink:",
		format_item = function(item)
			return item.text
		end,
	}, function(choice)
		if choice then
			open_url(choice.url)
		end
	end)
end

function M.pick()
	local items = all_items()
	if #items == 0 then
		vim.notify(
			"deeplink: no links configured (add some in setup() or a " .. M.config.project_file .. " file)",
			vim.log.levels.WARN
		)
		return
	end

	local mini_pick = mini_pick_ui_select()
	if mini_pick then
		-- Best-effort: falls back to plain vim.ui.select if this mini.pick
		-- version doesn't expose default_show / start the way we expect.
		local ok = pcall(pick_with_mini, mini_pick, items)
		if ok then
			return
		end
	end
	pick_with_vim_ui(items)
end

function M.reload()
	project_links_cache = load_project_links()
	vim.notify(
		"deeplink: reloaded " .. #project_links_cache .. " link(s) from " .. M.config.project_file,
		vim.log.levels.INFO
	)
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	vim.api.nvim_create_user_command("DeepLink", M.pick, {
		desc = "Pick and open a deeplink via xcrun simctl",
	})

	vim.api.nvim_create_user_command("DeepLinkOpen", function(cmd_opts)
		open_url(cmd_opts.args)
	end, {
		nargs = 1,
		desc = "Open a specific deeplink URL on the simulator",
	})

	vim.api.nvim_create_user_command("DeepLinkReload", M.reload, {
		desc = "Reload project-local deeplinks.json",
	})
end

return M
