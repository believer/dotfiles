return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Packer itself
  use 'tpope/vim-commentary' -- Easier comments (gc / gcc)
  use 'tpope/vim-fugitive' -- Git
  use 'tpope/vim-surround' -- Actions that work on surrounding context
  use 'github/copilot.vim' -- GitHub Copilot
  use 'nvim-lualine/lualine.nvim' -- Status line
  use 'mattn/emmet-vim' -- Emmet

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- LSP support
  use 'neovim/nvim-lspconfig' -- LSP configuration
  use 'williamboman/mason.nvim' -- Installer of LSPs and more
  use 'williamboman/mason-lspconfig.nvim' -- LSP configuration for Mason
  use 'hrsh7th/nvim-cmp' -- Autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- Completion for LSP
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- File tree
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly'
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {{'nvim-lua/plenary.nvim'}}
  }


  -- Theme
  use '~/code/personal/night-owl'
end)
