require("plugins")
require("settings")
require("highlight")

-- Run gofmt on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)
-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

lspconfig = require "lspconfig"
util = require "lspconfig/util"

lspconfig.gopls.setup{
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
	unusedparams = true,
	shadow = true,
      },
      staticcheck = true,
    },
  },
}

function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
	vim.lsp.util.apply_workspace_edit(r.edit)
      else
	vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_exec([[ autocmd  BufWritePre *.go lua OrgImports(1000) ]], false)
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
vim.api.nvim_exec([[ autocmd BufWritePre *.go lua vim.lsp.buf.formatting() ]], false)
