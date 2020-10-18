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

" Indent text on the same logical line
set breakindent

" Enable auto-complete
set wildmode=longest,list,full

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

let g:tex_flavor='latex'

" indentation
set sw=2
set iskeyword+=:

let b:suppress_latex_suite = 1

" Alt+X, Alt+C and Alt+V bindings:
execute "set <M-x>=\ex"
vnoremap <M-x> "+d
execute "set <M-c>=\ec"
vnoremap <M-c> "+y
execute "set <M-v>=\ev"
map <M-v> "+P

" Enable spell-check by default
setlocal spell! spelllang=en_us

" Toggle spell-check
map <F1> :setlocal spell! spelllang=en_us<CR>
map <F2> :setlocal spell! spelllang=en_gb<CR>
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

" Easy align https://github.com/junegunn/vim-easy-align
" Try gaip=, where = is symbol around which one want to align
" = can be preceded with the following:
" = Around the 1st occurrences
" 2= Around the 2nd occurrences
" *= Around all occurrences
" **= Left/Right alternating alignment around all occurrences
" <Enter> Switching between left/right/center alignment modes
" Additionally, :'<,'>EasyAlign&mrl*l1r1 can be used inside LaTeX tables 
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Surround text with symbols
Plug 'tpope/vim-surround'

" LaTeX
Plug 'lervag/vimtex'

" R markdown
Plug 'gabrielelana/vim-markdown'

" Python
Plug 'vim-syntastic/syntastic'
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']
Plug 'nvie/vim-flake8'
let python_highlight_all=1
syntax on
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
let g:pydocstring_formatter = 'numpy'
let g:pydocstring_doq_path = '~/.vim/venv/bin/doq'

" Check grammar
Plug 'rhysd/vim-grammarous'

" Go
Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"

call plug#end()

set nofoldenable " disable folding
set conceallevel=1
let g:tex_conceal = ""
autocmd bufreadpre *.md setlocal ft=tex 
autocmd bufreadpre *.rmd setlocal ft=tex 

" Change MatchParen colours
hi MatchParen cterm=none ctermbg=cyan ctermfg=yellow

" Change location of vimtex build
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'Output',
            \}

" Go
autocmd Filetype go set autoindent noexpandtab tabstop=4 shiftwidth=4

" Disable beeping
set noerrorbells
set vb t_vb=

" Define Pmenu autocompletion colours
" Unselected items
highlight Pmenu ctermfg=white guifg=white ctermbg=black guibg=black
" Selected item
highlight PmenuSel ctermfg=black guifg=black ctermbg=red guibg=red

" Define spell check highlight colors
hi SpellBad    ctermfg=007      ctermbg=009     cterm=none
hi SpellCap    ctermfg=009      ctermbg=007     cterm=none
hi SpellLocal  ctermfg=007      ctermbg=012     cterm=none
hi SpellRare   ctermfg=007      ctermbg=012     cterm=none

" Define selected text colors
hi Visual      ctermfg=000      ctermbg=015     cterm=none

set ttimeoutlen=0

" Convert markdown files to pdf
autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>-V<space>geometry:a4paper<space>-V<space>geometry:margin=3cm<space>-V<space>linkcolor:blue<space>-H<space>"/home/dovydas/.config/markdown-latex/text-formatting.sty"<space>-o<space><C-r>%<backspace><backspace>pdf<Enter>
autocmd Filetype rmd map <F5> :!pandoc<space><C-r>%<space>-V<space>geometry:a4paper<space>-V<space>geometry:margin=3cm<space>-V<space>linkcolor:blue<space>-H<space>"/home/dovydas/.config/markdown-latex/definitions.sty"<space>-H<space>"/home/dovydas/.config/markdown-latex/miscellaneous.sty"<space>-H<space>"/home/dovydas/.config/markdown-latex/text-formatting.sty"<space>-o<space><C-r>%<backspace><backspace><backspace>pdf<Enter>
