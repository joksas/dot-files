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
set nofixendofline
set noeol
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
execute "set <M-x>=\ex"
vnoremap <M-x> "+d
execute "set <M-c>=\ec"
vnoremap <M-c> "+y
execute "set <M-v>=\ev"
map <M-v> "+P

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
execute "set <M-j>=\ej"
:noremap <M-j> gj
execute "set <M-k>=\ek"
:noremap <M-k> gk
execute "set <M-l>=\el"
:noremap <M-l> g$
execute "set <M-h>=\eh"
:noremap <m-h> g0

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Try gaip=, where = is symbol around which one want to align
" = can be preceded with the following:
" = Around the 1st occurrences
" 2= Around the 2nd occurrences
" *= Around all occurrences
" **= Left/Right alternating alignment around all occurrences
" <Enter> Switching between left/right/center alignment modes
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Surround text with symbols
Plug 'tpope/vim-surround'

" LaTeX
Plug 'lervag/vimtex'

" R markdown
Plug 'gabrielelana/vim-markdown'

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
Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
au BufRead,BufNewFile *.html set filetype=gohtmltmpl
autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4
let g:go_fmt_fail_silently = 1

" CSS/SCSS
Plug 'ap/vim-css-color'


set nofoldenable " disable folding
set conceallevel=0

" Python
Plug 'heavenshell/vim-pydocstring'
let g:pydocstring_doq_path = '~/.local/bin/doq'
let g:pydocstring_templates_path = '~/.vim/templates/pydocstring'
set rtp^=~/.vim/plugged/vim-pydocstring

let g:ale_fixers['python'] = ['black', 'isort']

call plug#end()

" JavaScript
let g:ale_fixers['javascript'] = ['eslint']

" C
let g:ale_fixers['c'] = ['astyle']
let g:ale_fixers['cpp'] = ['astyle']

let g:ale_fix_on_save = 1

" Change MatchParen colours
hi MatchParen cterm=none ctermbg=cyan ctermfg=yellow

" Change location of vimtex build
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'output',
            \}

" Disable beeping
set noerrorbells
set vb t_vb=

" Highlight colors

" General
hi Visual ctermfg=000 ctermbg=007 cterm=bold
highlight LineNr ctermfg=015
highlight CursorLineNr ctermfg=002 cterm=bold
set cursorline
highlight Cursorline ctermfg=NONE ctermbg=016 cterm=NONE 
highlight Comment ctermfg=015
highlight Identifier ctermfg=012
highlight Constant ctermfg=003
highlight PreProc ctermfg=012
highlight Title ctermfg=003
highlight Statement ctermfg=004
highlight ErrorMsg ctermfg=007 ctermbg=009
highlight Search ctermfg=000 ctermbg=003

" Autocomplete menu
highlight Pmenu ctermfg=007 ctermbg=008
highlight PmenuSel ctermfg=000 ctermbg=004

" Spelling
hi SpellBad    ctermfg=009      ctermbg=000     cterm=underline
hi SpellCap    ctermfg=009      ctermbg=007     cterm=none
hi SpellLocal  ctermfg=001      ctermbg=000
hi SpellRare   ctermfg=007      ctermbg=012     cterm=none

" LaTeX
highlight texCmd ctermfg=012
highlight texArg ctermfg=001
highlight texMathArg ctermfg=003
highlight texMathGroup ctermfg=003
highlight texMathZoneEnv ctermfg=003
highlight texMathZoneX ctermfg=003

set ttimeoutlen=0

" See what highlight groups are used.
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Convert markdown files to pdf
autocmd BufEnter,BufNew *.md map <F5> :!pandoc<space><C-r>%<space>-H<space>"/home/dovydas/.config/markdown-latex/base.sty"<space>--citeproc<space>-o<space><C-r>%<backspace><backspace>pdf<Enter>
