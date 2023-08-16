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

M.utils = {
  n = {
    ["<F5>"] = {
      function()
        if vim.bo.filetype == "markdown" or vim.bo.filetype == "vimwiki" then
          local fileName = vim.fn.expand("%:p")
          local fileNameNoExt = vim.fn.expand("%:p:r")
          vim.cmd("!pandoc " .. fileName .. " -H $HOME/.config/markdown-latex/base.sty --highlight=breezedark --pdf-engine=xelatex -V fontsize=12pt --citeproc -o " .. fileNameNoExt .. ".pdf")
        elseif vim.bo.filetype == "bib" then
          local fileName = vim.fn.expand("%:p")
          vim.cmd("!biber --tool --output-indent=2 --output-align --output-fieldcase=lower --output-format=bibtex --nolog --output-file=" .. fileName .. " " .. fileName)
          vim.cmd(":e")
        else
          vim.cmd("echo 'No operation for filetype `" .. vim.bo.filetype .. "`'")
        end
      end,
    },
  },
}

return M

