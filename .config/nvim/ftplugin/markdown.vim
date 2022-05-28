function UpdateLastmod()
  let @a = system('echo "lastmod = \"$(date +\%Y-\%m-\%dT\%H:\%M:\%S\%:z)\""')[:-2]
  try
    %s/lastmod *= *".*"/\=@a/
  catch
    return
  endtry
  normal ``
endfunction


map <F5> :!pandoc '<C-r>%' -H "$HOME/.config/markdown-latex/base.sty" --pdf-engine=xelatex -V fontsize=12pt --citeproc -o '<C-r>%<backspace><backspace>pdf'<Enter>

autocmd BufWritePre *.md call UpdateLastmod()
