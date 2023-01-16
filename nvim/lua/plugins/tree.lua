-- File tree
local map = require("utils").map

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    -- Add devicons
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = true,
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          --auto close
          require("neo-tree").close_all()
        end,
      },
    },
    window = {
      position = "right",
      mappings = {
        ["s"] = "open_vsplit",
        ["<C-v>"] = "open_vsplit",
      },
    },
  },
  init = function()
    map("n", "<leader>d", vim.cmd.NeoTreeFocusToggle)
    map("n", "<leader>f", vim.cmd.NeoTreeReveal)
  end,
}
