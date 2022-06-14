vim.opt.termguicolors = true

vim.cmd("colorscheme jellybeans")

local black   = '#202020'
local red     = '#f2777a'
local green   = '#99cc99'
local yellow  = '#ffcc66'
local blue    = '#6699cc'
local magenta = '#cc99cc'
local cyan    = '#66cccc'
local white   = '#d3d0c8'

local blackLight   = '#747369'
local redLight     = '#ff0000'
local greenLight   = '#99cc99'
local yellowLight  = '#ffcc66'
local blueLight    = '#6699cc'
local magentaLight = '#cc99cc'
local cyanLight    = '#66cccc'
local whiteLight   = '#f2f0ec'

local yellowA = '#472f00'

-- Gutters
vim.highlight.create("SignColumn", { ctermbg = 0, guibg = "none" }, false)
vim.highlight.create("GitGutterAdd", { ctermfg = 2, guifg = green }, false)
vim.highlight.create("GitGutterDelete", { ctermfg = 1, guifg = red }, false)
vim.highlight.create("GitGutterChange", { ctermfg = 4, guifg = blue }, false)

-- Diagnostics
vim.highlight.create("DiagnosticUnderlineError", { ctermfg = "none", ctermbg = "none", cterm = "undercurl", gui = "undercurl", guifg = redLight, guibg = "none", guisp = redLight }, false)
vim.highlight.create("DiagnosticUnderlineWarn", { ctermfg = "none", ctermbg = "none", cterm = "undercurl", gui = "undercurl", guifg = yellow, guibg = "none", guisp = yellow }, false)

-- Spelling
vim.highlight.create("SpellBad", { ctermfg = "none", ctermbg = "none", cterm = "undercurl", gui = "undercurl", guifg = "none", guibg = "none", guisp = red }, false)
vim.highlight.create("SpellCap", { ctermfg = "none", ctermbg = "none", cterm = "undercurl", gui = "undercurl", guifg = "none", guibg = "none", guisp = yellow }, false)
vim.highlight.create("SpellLocal", { ctermfg = "none", ctermbg = "none", cterm = "undercurl", gui = "undercurl", guifg = "none", guibg = "none", guisp = blueLight }, false)
vim.highlight.create("SpellRare", { ctermfg = 1, guifg = whiteLight, ctermbg = 12, guibg = blueLight, cterm = "none" }, false)

-- Search
vim.highlight.create("Search", { ctermfg = 1, ctermbg = 3, cterm = "none", guifg = black, guibg = yellow, gui = "none" }, false)

-- Status line
vim.highlight.create("User1", { ctermfg = 0, guifg = black, ctermbg = 11, guibg = yellow }, false)

-- Transparent background
vim.api.nvim_set_hl(0, "CursorLine", {})
vim.highlight.create("Normal", { ctermbg = "none", guibg = "none" })
vim.highlight.create("LineNr", { ctermbg = "none", guibg = "none", guifg = "gray" })
vim.highlight.create("Folded", { ctermbg = "none", guibg = "none" })
vim.highlight.create("NonText", { ctermbg = "none", guibg = "none", guifg = "gray" })
vim.wo.fillchars = "eob: "
vim.highlight.create("SpecialKey", { ctermbg = "none", guibg = "none" })
vim.highlight.create("VertSplit", { ctermbg = "none", guibg = "none" })
vim.highlight.create("SignColumn", { ctermbg = "none", guibg = "none" })

vim.highlight.create("Normal", { guibg = "none", ctermbg = "none" })
vim.highlight.create("CursorColumn", { cterm = "none", ctermbg = "none", ctermfg = "none", guibg = black })
vim.highlight.create("CursorLine", { cterm = "none", ctermbg = "none", ctermfg = "none", guibg = black })
vim.highlight.create("CursorLineNr", { cterm = "none", ctermbg = "none", guibg = black, ctermfg = "yellow", guifg = yellow })
vim.api.nvim_set_hl(0, "StatusLine", {})
