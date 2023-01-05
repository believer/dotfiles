local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>af", mark.add_file)
vim.keymap.set("n", "<leader>rf", mark.rm_file)
vim.keymap.set("n", "<leader>cf", mark.clear_all)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
