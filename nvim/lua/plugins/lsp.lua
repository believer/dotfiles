return {
  {
    "williamboman/mason.nvim", -- Installer of LSPs and more
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- LSP configuration for Mason
    },
    opts = {
      ensure_installed = {
        "cssls",
        "eslint_d",
        "prettierd",
        "rescriptls",
        "rust_analyzer",
        "sumneko_lua",
        "tailwindcss",
        "volar",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local map = require("utils").map

      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      map("n", "<leader>e", vim.diagnostic.open_float)
      map("n", "[d", vim.diagnostic.goto_prev)
      map("n", "]d", vim.diagnostic.goto_next)
      map("n", "<leader>q", vim.diagnostic.setloclist)

      -- Map the keys after the language server is attached to the buffer.
      local on_attach = function(_, bufnr)
        local bufopts = { buffer = bufnr }

        map("n", "gD", vim.lsp.buf.declaration, bufopts)
        map("n", "gd", vim.lsp.buf.definition, bufopts)
        map("n", "K", vim.lsp.buf.hover, bufopts)
        map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
      end

      lspconfig.volar.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- Use Volar for all JavaScript and TypeScript code as it also handles Vue correctly
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      })

      lspconfig.sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              enable = true,
              globals = { "vim" },
            },
          },
        },
      })

      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.rescriptls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        -- Format on save
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
                vim.cmd("EslintFixAll")
              end,
            })
          end
        end,

        sources = {
          b.completion.spell,
          b.diagnostics.stylelint,
          b.formatting.prettier,
          b.formatting.stylua,
          b.formatting.rescript,
          b.formatting.rustfmt,
        },
      })
    end,
  },
}
