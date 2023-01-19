return {
  "folke/which-key.nvim",
  config = function()
    -- Shorten timeout to wait for mappings to complete
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    require("which-key").setup()

    local wk = require("which-key")

    wk.register({
      ["<leader>"] = {
        a = {
          name = "+actions",
          b = { '"_', "Black hole register" },
          d = { 'diwxda"<CR>', "Delete HTML attribute" },
        },

        -- Diagnostics
        e = {
          name = "+diagnostics",
          d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show error in float window" },
          l = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Display diagnostics to location list" },
          n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
          p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic" },
        },

        -- Tree view
        d = { "<cmd>NeoTreeFocusToggle<CR>", "Toggle the tree view" },
        f = { "<cmd>NeoTreeReveal<CR>", "Reveal the current file in the tree view" },

        -- Git
        g = {
          name = "+git",
          b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle git blame on line" },
          p = { "<cmd>Git push<CR>", "git push" },
          s = { "<cmd>Git<CR>", "git status" },
          u = { "<cmd>!git up<CR>", "git up" },
        },

        -- Harpoon
        h = {
          name = "+harpoon",
          a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add file to harpoon" },
          c = { "<cmd>lua require('harpoon.mark').clear_all()<CR>", "Clear all files from harpoon" },
          l = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle quick menu" },
          n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Next file" },
          p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Previous file" },
          r = { "<cmd>lua require('harpoon.mark').rm_file()<CR>", "Remove file from harpoon" },
          ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Navigate to file 1" },
          ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Navigate to file 2" },
          ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Navigate to file 3" },
          ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Navigate to file 4" },
        },

        -- Telescope
        [";"] = { "<cmd>Telescope find_files<CR>", "Find files" },
        ["?"] = { "<cmd>Telescope live_grep<CR>", "Grep in all files" },
        t = {
          name = "+telescope",
          b = { "<cmd>Telescope buffers<CR>", "Open buffers" },
          d = { "<cmd>Telescope lsp_document_symbols<CR>", "Symbols in document" },
          f = { "<cmd>Telescope find_files<CR>", "Telescope find files" },
          h = { "<cmd>Telescope help_tags<CR>", "Telescope help tags" },
          m = { "<cmd>Telescope marks<CR>", "Telescope marks" },
          o = { "<cmd>Telescope oldfiles<CR>", "Recently opened files" },
          s = { "<cmd>Telescope spell_suggest<CR>", "Suggest spelling" },
          w = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Symbols in workspace" },
        },

        y = { '"+y', "Copy to system clipboard", mode = "v" },
      },
    })
  end,
}
