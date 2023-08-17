local plugins = {
  {
    "williamboman/mason.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
      vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "github/copilot.vim",
    ft = {"rust", "lua", "markdown", "vimwiki", "toml", "text", "tex", "latex", "typescript", "javascript", "html", "css", "python", "go", "sql", "dockerfile" },
    init = function()
      vim.g.copilot_node_command = "~/.nvm/versions/node/v17.9.0/bin/node"
      vim.g.copilot_assume_mapped = true
    end,
  },
  {
    "vimwiki/vimwiki",
    branch = "dev",
    ft = "markdown",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "$HOME/Documents/wiki",
          syntax = "markdown",
          ext = ".md",
          template_path = "$HOME/Documents/wiki/.template",
          template_default = "default",
          custom_wiki2html = "vimwiki_markdown",
        },
      }
      vim.g.vimwiki_table_mappings = 0
      vim.api.nvim_exec([[ autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR> ]], false)
      vim.g.mdip_imgdir = ".assets"
      vim.api.nvim_exec([[ au FileType vimwiki silent! iunmap <buffer> <Tab> ]], false)
    end,
  },
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<Tab>"] = function(callback)
          callback()
        end,

        ["<S-Tab>"] = function(callback)
          callback()
        end,

        -- use Up and down for cycling completion
        ["<Down>"] = require("cmp").mapping(function(fallback)
          local cmp = require "cmp"
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
        ["<Up>"] = require("cmp").mapping(function(fallback)
          local cmp = require "cmp"
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ft = { "rust", "lua", "markdown", "vimwiki", "toml", "text", "tex", "latex", "typescript", "javascript", "html", "css", "python", "go", "sql", "dockerfile" },
    opts = {
      cycle_results = false,
    }
  },
}

return plugins
