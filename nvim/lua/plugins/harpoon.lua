-- Quickly navigate between files
return {
  "ThePrimeagen/harpoon",
  config = function()
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
