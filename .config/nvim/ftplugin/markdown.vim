map <F5> :!pandoc <C-r>% -H "$HOME/.config/markdown-latex/base.sty" -V fontsize=12pt --citeproc -o <C-r>%<backspace><backspace>pdf<Enter>
