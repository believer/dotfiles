return {
  {
    "williamboman/mason.nvim", -- Installer of LSPs and more
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
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Map the keys after the language server is attached to the buffer.
      local on_attach = function(_, bufnr)
        local wk = require("which-key")

        wk.register({
          g = {
            D = { vim.lsp.buf.declaration, "Go to declaration", buffer = bufnr },
            d = { vim.lsp.buf.definition, "Go to definition", buffer = bufnr },
          },
          ["K"] = { vim.lsp.buf.hover, "Hover", buffer = bufnr },
          ["<leader>rn"] = { vim.lsp.buf.rename, "Rename", buffer = bufnr },
          ["<leader>ca"] = { vim.lsp.buf.code_action, "Code action", buffer = bufnr },
        })
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
            format = {
              enable = true,
            }
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
    dependencies = {
      "lukas-reineke/lsp-format.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- add to your shared on_attach callback
      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end
      end

      null_ls.setup({
        debug = true,

        -- Format on save
        on_attach = on_attach,

        sources = {
          b.completion.spell,
          b.diagnostics.stylelint,
          b.formatting.prettierd,
          b.formatting.eslint_d,
          b.formatting.rescript,
          b.formatting.rustfmt,
        },
      })
    end,
  },
}
