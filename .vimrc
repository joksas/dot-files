set autoindent
set expandtab

set hlsearch
set ignorecase
set smartcase
set display+=lastline

syntax enable
set wrap
set laststatus=2
set ruler
set number relativenumber

" Enable auto-complete
set wildmode=longest,list,full

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" identation
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

let b:suppress_latex_suite = 1

" Alt+X, Alt+C and Alt+V bindings:
vnoremap <A-x> "+d
vnoremap <A-c> "+y
map <A-v> "+P

" Enable spell-check with F1
map <F1> :setlocal spell! spelllang=en_gb<CR>

" Remap keys for moving in visual lines
:noremap <A-j> gj
:noremap <A-k> gk
:noremap <A-$> g$
:noremap <A-0> g0

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Easy align https://github.com/junegunn/vim-easy-align
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

" Vimtex
Plug 'lervag/vimtex'

" R markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'vim-pandoc/vim-rmarkdown'

" Initialize plugin system
call plug#end()

set nofoldenable " disable folding
set conceallevel=1
let g:tex_conceal = ""
autocmd bufreadpre *.md setlocal ft=tex 
autocmd bufreadpre *.rmd setlocal ft=tex 

" Change MatchParen colours
hi MatchParen cterm=none ctermbg=magenta ctermfg=yellow

" Change location of vimtex build
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'Output',
            \}

" Disable beeping
set noerrorbells
set vb t_vb=

" Define Pmenu autocompletion colours
" Unselected items
highlight Pmenu ctermfg=white guifg=white ctermbg=black guibg=black
" Selected item
highlight PmenuSel ctermfg=black guifg=black ctermbg=red guibg=red

" Convert markdown files to pdf
autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>-V<space>geometry:a4paper<space>-V<space>geometry:margin=3cm<space>-V<space>linkcolor:blue<space>-H<space>"/home/dovydas/Documents/Notes/Setup/definitions.sty"<space>-H<space>"/home/dovydas/Documents/Notes/Setup/miscellaneous.sty"<space>-H<space>"/home/dovydas/Documents/Notes/Setup/text_formatting.sty"<space>-o<space><C-r>%<backspace><backspace>pdf<Enter>
autocmd Filetype rmd map <F5> :!pandoc<space><C-r>%<space>-V<space>geometry:a4paper<space>-V<space>geometry:margin=3cm<space>-V<space>linkcolor:blue<space>-H<space>"/home/dovydas/Documents/Notes/Setup/definitions.sty"<space>-H<space>"/home/dovydas/Documents/Notes/Setup/miscellaneous.sty"<space>-H<space>"/home/dovydas/Documents/Notes/Setup/text_formatting.sty"<space>-o<space><C-r>%<backspace><backspace><backspace>pdf<Enter>