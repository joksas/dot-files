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

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

let b:suppress_latex_suite = 1

" CTRL+X, CTRL+C and CTRL+V bindings:
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

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Vimtex
Plug 'lervag/vimtex'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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
