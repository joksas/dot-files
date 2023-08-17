local M = {}

M.clipboard = {
  n = {
    ["<A-v>"] = { '"+P', "Paste from clipboard" },
  },

  v = {
    ["<A-c>"] = { '"+y', "Copy to clipboard" },
    ["<A-x>"] = { '"+d', "Cut to clipboard" },
  },
}

M.spellcheck = {
  n = {
    ["<F1>"] = { ":setlocal spell! spelllang=en_gb<CR>", "Spell check: English (GB)" },
    ["<F2>"] = { ":setlocal spell! spelllang=en_us<CR>", "Spell check: English (US)" },
    ["<F3>"] = { ":setlocal spell! spelllang=lt<CR>", "Spell check: Lithuanian" },
  },
}

M.pandoc = {
  n = {
    ["<F5>"] = { ":!pandoc '<C-r>%' -H \"$HOME/.config/markdown-latex/base.sty\" --highlight=breezedark --pdf-engine=xelatex -V fontsize=12pt --citeproc -o '<C-r>%<backspace><backspace>pdf'<Enter>", "Pandoc: Convert to PDF" },
  },
}

M.errors = {
  n = {
    ["<leader>e"] = { ":Trouble<CR>", "Show errors" },
  },
}

return M
