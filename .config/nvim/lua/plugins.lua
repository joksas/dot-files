require('packer').startup(function()
  -- Neovim infrastructure
  use 'wbthomason/packer.nvim'
  use "neovim/nvim-lspconfig"
  use 'mfussenegger/nvim-lint'

  -- Display
  use 'nanotech/jellybeans.vim'

  -- Language-specific tools
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'lervag/vimtex'
  use { 'fatih/vim-go', ft = 'gohtmltmpl' }

  -- Other tools
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'github/copilot.vim'
  use 'tpope/vim-surround'
  use 'airblade/vim-gitgutter'
  use 'vimwiki/vimwiki'
end)

vim.g.vimwiki_list = {
  {
    path = '$HOME/Documents/wiki/',
    syntax = 'markdown',
    ext = '.md',
    template_path = '$HOME/Documents/wiki/.templates',
    template_default = 'default',
    custom_wiki2html = 'vimwiki_markdown',
  }
}

vim.g.vimwiki_table_mappings = 0
