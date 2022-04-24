vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.display:append { "lastline" }
vim.opt.syntax = "enable"
vim.opt.compatible = false
vim.opt.wrap = true
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.iskeyword:remove {":"}

vim.opt.wildmode = {"longest", "list", "full"}
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.completeopt:remove {"preview"}

vim.opt.filetype.indent = true
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

map("n", "<F10>", ':echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . ">trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>', {})

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

-- Status line
vim.opt.statusline = ""
vim.opt.statusline:append "%1*%<%t%*"  -- filename
vim.opt.statusline:append "%1* %y%*"  -- file type
vim.opt.statusline:append "%1*%m%*"  -- modified flag
vim.opt.statusline:append "%1*%=%5l%*"  -- current line
vim.opt.statusline:append "%1*/%L%*"  -- total lines
vim.opt.statusline:append "%1*%4v %*"  -- virtual column number

require('lint').linters_by_ft = {
  tex = {
    'chktex',
  },
}
vim.cmd [[ au BufWritePost <buffer> lua require('lint').try_lint() ]]

vim.g.vimtex_compiler_latexmk = {
  build_dir = '.aux',
}

vim.cmd [[ au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl.html ]]
vim.cmd [[ au BufRead,BufNewFile *.html set filetype=gohtmltmpl.html ]]

require("nvim-treesitter.configs").setup({
  indent = {
    enable = true,
  },
})

local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}
