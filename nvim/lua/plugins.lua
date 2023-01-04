return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer itself
  use 'tpope/vim-commentary' -- Easier comments (gc / gcc)
  use 'tpope/vim-fugitive' -- Git
  use 'tpope/vim-surround' -- Actions that work on surrounding context
  use 'github/copilot.vim' -- GitHub Copilot
  use 'mattn/emmet-vim' -- Emmet

  -- Git signs in the gutter
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'plugins.gitsigns'
    end,
  }

  -- Lualine - Status line
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'plugins.lualine'
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.treesitter'
    end,
    requires = {
      'windwp/nvim-ts-autotag', -- Automatically close/update HTML tags
    },
  }

  -- LSP support
  use 'neovim/nvim-lspconfig'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'plugins.null_ls'
    end,
  }

  use 'williamboman/mason.nvim' -- Installer of LSPs and more
  use 'williamboman/mason-lspconfig.nvim' -- LSP configuration for Mason

  -- Snippets
  use {
    'L3MON4D3/LuaSnip',
    tag = 'v<CurrentMajor>.*'
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'plugins.cmp'
    end,
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
  }

  -- File tree
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly',
    config = function()
      require 'plugins.tree'
    end,
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.telescope'
    end,
  }

  -- Theme
  use 'folke/tokyonight.nvim'

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'plugins.autopairs'
    end,
  }
end)
