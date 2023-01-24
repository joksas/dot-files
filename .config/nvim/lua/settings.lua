vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.iskeyword:remove { ":" }
vim.opt.display:append { "lastline" }

vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.completeopt:remove { "preview" }

vim.opt.filetype.indent = true
vim.opt.expandtab = true
vim.opt.sw = 2
vim.opt.updatetime = 100

local map = vim.api.nvim_set_keymap
map("v", "<A-x>", '"+d', {})
map("v", "<A-c>", '"+y', {})
map("", "<A-v>", '"+P', {})

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_gb"

map("", "<F1>", ":setlocal spell! spelllang=en_gb<CR>", {})
map("", "<F2>", ":setlocal spell! spelllang=en_us<CR>", {})
map("", "<F3>", ":setlocal spell! spelllang=lt<CR>", {})

map("n", "<A-j>", "gj", {})
map("n", "<A-k>", "gk", {})
map("n", "<A-l>", "gl", {})
map("n", "<A-h>", "gh", {})

map("n", "<F10>",
  ':echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . ">trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>'
  , {})

-- Make nvim the right size when opening from Ranger.
vim.api.nvim_exec([[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]], false)

vim.opt.cursorline = true

vim.api.nvim_exec([[ autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4 ]], false)

vim.o.updatetime = 100
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

vim.g.vimtex_compiler_latexmk = {
  build_dir = '.aux',
}

vim.cmd [[ au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl ]]
vim.cmd [[ au BufRead,BufNewFile *.html set filetype=gohtmltmpl ]]

local c = require('onedark.colors')

-- Spelling
vim.api.nvim_set_hl(0, "SpellBad",
  { undercurl = true, fg = "none", bg = "none",
    sp = c.red })
vim.api.nvim_set_hl(0, "SpellCap",
  { undercurl = true, fg = "none", bg = "none",
    sp = c.yellow })
vim.api.nvim_set_hl(0, "SpellLocal",
  { undercurl = true, fg = "none", bg = "none",
    sp = c.blue })
vim.api.nvim_set_hl(0, "SpellRare", { fg = c.white, bg = c.blue, })

local embedded_html = vim.treesitter.parse_query(
  "rust",
  [[
(macro_invocation
  (scoped_identifier
    path: (identifier) @path (#eq? @path "leptos")
    name: (identifier) @name (#eq? @name "view"))

  (token_tree 
      (_) @html
    )
  )
  ]]
)

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "rust", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local run_formatter = function(html)
  local tmp = vim.fn.tempname()
  vim.fn.writefile({ html }, tmp)

  local cmd = "prettier --stdin-filepath index.html --parser html"
  local formatted = vim.fn.system(cmd, html)

  vim.fn.delete(tmp)

  return vim.split(formatted, " ")
end

local format_dat_html = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].filetype ~= "rust" then
    vim.notify "can only be used in Rust"
    return
  end

  local root = get_root(bufnr)

  local changes = {}
  for id, node in embedded_html:iter_captures(root, bufnr, 0, -1) do
    local name = embedded_html.captures[id]
    if name == "html" then
      local range = { node:range() }
      local indentation = vim.fn.indent(range[1])

      local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

      for idx, line in ipairs(formatted) do
        formatted[idx] = indentation .. line
      end

      table.insert(changes, 1, {
        start = range[1] + 1,
        final = range[3],
        formatted = formatted,
      })
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
  end
end

vim.api.nvim_create_user_command("FormatDatHtml", function()
  format_dat_html()
end, {})

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
