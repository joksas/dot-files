local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })

    -- format on save if formatter is available
    if func == vim.lsp.buf.format then
      vim.api.nvim_exec([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = true } ]], false)
    elseif func == vim.lsp.buf.formatting then
      vim.api.nvim_exec([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting { async = true } ]], false)
    end
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format()
		elseif vim.lsp.buf.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = 'Format current buffer with LSP' })
end

local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unusedvariable = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

vim.api.nvim_exec([[ autocmd BufWritePre *.go lua vim.lsp.buf.format { async = true } ]], false)

function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_exec([[ autocmd BufWritePre *.go lua OrgImports(1000) ]], false)

-- CSS
lspconfig.cssls.setup{}
lspconfig.tailwindcss.setup{}

-- Javascript/Typescript

lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

vim.api.nvim_exec([[ autocmd BufWritePre *.ts lua vim.lsp.buf.format { async = true } ]], false)

-- custom settings for ltex
lspconfig.ltex.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "ltex-ls" },
  filetypes = { "text", "markdown", "tex", "latex", "org" },
  flags = { debounce_text_changes = 300 },
}

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "texlab" },
  filetypes = { "tex", "latex" },
  flags = { debounce_text_changes = 300 },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
       pycodestyle = {
          maxLineLength = 100,
          ignore = { "E203" },
        },
      },
    },
  },
}
vim.api.nvim_exec([[ autocmd BufWritePre *.py lua vim.lsp.buf.format { async = false } ]], false)
