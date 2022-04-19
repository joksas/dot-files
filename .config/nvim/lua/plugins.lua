return require('packer').startup(function()
  -- Neovim infrastructure
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'mfussenegger/nvim-lint'

  -- Display
  use 'nanotech/jellybeans.vim'

  -- Language-specific tools
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'lervag/vimtex'
  -- use 'fatih/vim-go'

  -- Other tools
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'github/copilot.vim'
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
end)
