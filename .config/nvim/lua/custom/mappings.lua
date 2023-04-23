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

return M

