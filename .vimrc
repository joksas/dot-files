set autoindent

set hlsearch
set ignorecase
set smartcase
set display+=lastline

syntax enable
set wrap
set laststatus=2
set ruler
set number relativenumber
set linebreak
set iskeyword-=:

" Indent text on the same logical line
set breakindent

" Enable auto-complete
set wildmode=longest,list,full
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" indentation
set sw=2
set iskeyword+=:

" Alt+X, Alt+C and Alt+V bindings:
vnoremap <A-x> "+d
vnoremap <A-c> "+y
map <A-v> "+P

" Enable spell-check by default
setlocal spell! spelllang=en_gb

" Enable US English in Markdown files
au BufNewFile,BufRead *.md setlocal spelllang=en_us
" https://stsievert.com/blog/2016/01/06/vim-jekyll-mathjax/
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction
" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()


" Toggle spell-check
map <F1> :setlocal spell! spelllang=en_gb<CR>
map <F2> :setlocal spell! spelllang=en_us<CR>
map <F3> :setlocal spell! spelllang=lt<CR>

" Remap keys for moving in visual lines
:noremap <A-j> gj
:noremap <A-k> gk
:noremap <A-l> g$
:noremap <A-h> g0

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Spacing
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Surround text with symbols
Plug 'tpope/vim-surround'

" LaTeX
Plug 'lervag/vimtex'

" R markdown
" Plug 'gabrielelana/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'

" Tables
Plug 'godlygeek/tabular'

" Ale
Plug 'dense-analysis/ale'
let g:ale_fixers = {}

" Git
Plug 'airblade/vim-gitgutter'
set updatetime=100
highlight! link SignColumn LineNr
highlight  GitGutterAdd    ctermfg=2
highlight  GitGutterDelete ctermfg=1
highlight  GitGutterChange ctermfg=4

" JSON
au BufRead,BufNewFile *.json.log set filetype=json

" Go
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl.html
au BufRead,BufNewFile *.html set filetype=gohtmltmpl.html
autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_fmt_fail_silently = 1

" Rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" CSS/SCSS
Plug 'ap/vim-css-color'


set nofoldenable " disable folding
set conceallevel=0

Plug 'github/copilot.vim'

" Python
Plug 'heavenshell/vim-pydocstring'
let g:pydocstring_doq_path = '~/.local/bin/doq'
let g:pydocstring_templates_path = '~/.vim/templates/pydocstring'
set rtp^=~/.vim/plugged/vim-pydocstring

let g:ale_fixers['python'] = ['black', 'isort']

call plug#end()

" JavaScript
let g:ale_fixers['javascript'] = ['eslint']
Plug 'maxmellon/vim-jsx-pretty'

" C
let g:ale_fixers['c'] = ['astyle']
let g:ale_fixers['cpp'] = ['astyle']

let g:ale_fix_on_save = 1

" Change MatchParen colours
hi MatchParen cterm=bold ctermbg=none ctermfg=none

" Change location of vimtex build
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'output',
            \}

" Disable beeping
set noerrorbells
set vb t_vb=

" Highlight colors

" General
highlight CursorLineNr ctermfg=000 ctermbg=003 cterm=bold
set cursorline
highlight Cursorline ctermfg=NONE cterm=NONE 
""" highlight Comment ctermfg=011
""" highlight Identifier ctermfg=012
""" highlight Constant ctermfg=003
""" highlight PreProc ctermfg=012
""" highlight Title ctermfg=003
""" highlight Statement ctermfg=004
""" highlight ErrorMsg ctermfg=007 ctermbg=009
""" highlight Search ctermfg=000 ctermbg=003

" Autocomplete menu
highlight Pmenu ctermfg=015 ctermbg=008
highlight PmenuSel ctermfg=000 ctermbg=015

" Spelling
hi SpellBad    ctermfg=001      ctermbg=000     cterm=underline
hi SpellCap    ctermfg=001      ctermbg=007     cterm=none
hi SpellLocal  ctermfg=009      ctermbg=000
hi SpellRare   ctermfg=015      ctermbg=012     cterm=none

""" " LaTeX
""" highlight texCmd ctermfg=004
""" highlight texArg ctermfg=009
""" highlight texMathArg ctermfg=011
""" highlight texMathGroup ctermfg=011
""" highlight texMathZoneEnv ctermfg=011
""" highlight texMathZoneX ctermfg=011
""" 
""" set ttimeoutlen=0

" Status line
set statusline=
set statusline +=%1*%<%t%*            "full path
set statusline +=%1*\ %y%*            "file type
set statusline +=%1*%m%*              "modified flag
set statusline +=%1*%=%5l%*           "current line
set statusline +=%1*/%L%*             "total lines
set statusline +=%1*%4v\ %*           "virtual column number
hi User1 ctermfg=000  ctermbg=011

let g:vimtex_compiler_latexmk = {'build_dir' : '.aux'}

" See what highlight groups are used.
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Convert markdown files to pdf
autocmd BufEnter,BufNew *.md map <F5> :!pandoc<space><C-r>%<space>-H<space>"/home/dovydas/.config/markdown-latex/base.sty"<space>-V<space>fontsize=12pt<space>--citeproc<space>-o<space><C-r>%<backspace><backspace>pdf<Enter>

" Format BibTeX files
autocmd BufWritePost *.bib execute '!biber --tool --output-indent=2 --output-align --output-fieldcase=lower --output-format=bibtex --nolog --output-file=%:p %:p' | e

" https://github.com/neovim/neovim/issues/11330#issuecomment-723667383
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
