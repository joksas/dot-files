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

  -- Other tools
  use 'github/copilot.vim'
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
end)
