local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function button(sc, txt, keybind, keybind_opts, opts)
  local def_opts = {
    cursor = 5,
    align_shortcut = "right",
    hl_shortcut = "AlphaButtonShortcut",
    hl = "AlphaButton",
    width = 35,
    position = "center",
  }
  opts = opts and vim.tbl_extend("force", def_opts, opts) or def_opts
  opts.shortcut = sc
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<Leader>")
  local on_press = function()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end
  if keybind then
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end
  return { type = "button", val = txt, on_press = on_press, opts = opts }
end

local function info()
  local v = vim.version()
  local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
  local platform = vim.fn.has("win32") == 1 and "" or ""
  return string.format("v%d.%d.%d %s  %s", v.major, v.minor, v.patch, platform, datetime)
end

local function mru()
  local result = {}
  for _, filename in ipairs(vim.v.oldfiles) do
    if file_exists(filename) then
      local icon, hl = require("nvim-web-devicons").get_icon(filename, vim.fn.fnamemodify(filename, ":e"))
      local filename_short = string.sub(vim.fn.fnamemodify(filename, ":t"), 1, 30)
      table.insert(
        result,
        button(
          tostring(#result + 1),
          string.format("%s  %s", icon, filename_short),
          string.format("<Cmd>e %s<CR>", filename),
          nil,
          { hl = hl }
        )
      )
      if #result == 9 then
        break
      end
    end
  end
  return result
end

return {
  "goolord/alpha-nvim",
  config = function()
    local marginTopPercent = 0.4
    local fn = vim.fn
    local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

    local config = {
      layout = {
        { type = "padding", val = headerPadding },
        {
          type = "text",
          val = {
            [[ __   __     ______     ______     __   __  __     __    __   ]],
            [[/\ "-.\ \   /\  ___\   /\  __ \   /\ \ / / /\ \   /\ "-./  \  ]],
            [[\ \ \-.  \  \ \  __\   \ \ \/\ \  \ \ \'/  \ \ \  \ \ \-./\ \ ]],
            [[ \ \_\\"\_\  \ \_____\  \ \_____\  \ \__|   \ \_\  \ \_\ \ \_\]],
            [[  \/_/ \/_/   \/_____/   \/_____/   \/_/     \/_/   \/_/  \/_/]],
          },
          opts = { hl = "Number", position = "center" },
        },
        { type = "padding", val = 1 },
        {
          type = "text",
          val = info(),
          opts = { position = "center" },
        },
        { type = "padding", val = 4 },
        {
          type = "group",
          val = mru,
          opts = { spacing = 0 },
        },
      },
    }

    require("alpha").setup(config)
  end,
}
