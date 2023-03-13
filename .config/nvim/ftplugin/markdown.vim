map <F5> :!pandoc '<C-r>%' -H "$HOME/.config/markdown-latex/base.sty" --highlight=breezedark --pdf-engine=xelatex -V fontsize=12pt --citeproc -o '<C-r>%<backspace><backspace>pdf'<Enter>
map <F6> :!pandoc '<C-r>%' -H "$HOME/.config/markdown-latex/base.sty" '<C-r>%<backspace><backspace>docx'<Enter>
