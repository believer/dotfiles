  -- Quickly navigate between files
return {
  "ThePrimeagen/harpoon",
  config = function()
    local map = require("utils").map
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    map("n", "<leader>ha", mark.add_file)
    map("n", "<leader>hr", mark.rm_file)
    map("n", "<leader>hc", mark.clear_all)
    map("n", "<leader>hn", ui.nav_next)
    map("n", "<leader>hp", ui.nav_prev)
    map("n", "<C-e>", ui.toggle_quick_menu)

    -- Quick navigate between files
    map("n", "<leader>1", function()
      ui.nav_file(1)
    end)
    map("n", "<leader>2", function()
      ui.nav_file(2)
    end)
    map("n", "<leader>3", function()
      ui.nav_file(3)
    end)
    map("n", "<leader>4", function()
      ui.nav_file(4)
    end)

    -- Add ability to open files in a split
    local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      group = group,
      callback = function()
        vim.keymap.set("n", "<C-V>", function()
          local curline = vim.api.nvim_get_current_line()
          local working_directory = vim.fn.getcwd() .. "/"
          vim.cmd("vs")
          vim.cmd("e " .. working_directory .. curline)
        end, { noremap = true, silent = true })
      end,
    })
  end,
}
