
" PLUGINS

call plug#begin('~/.config/nvim/plugged')

" Nerd Tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Status Line plug-ins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'			" Adds git branch to status bar

" Color scheme plug-ins
Plug 'arcticicestudio/nord-vim'		" Nord color scheme
Plug 'dracula/vim' 					" Dracula color scheme
Plug 'joshdick/onedark.vim'			" OneDark color scheme
Plug 'morhetz/gruvbox'				" Gruvbox color scheme
Plug 'tomasr/molokai' 				" Molokai color scheme

" Others
Plug 'airblade/vim-gitgutter'		" Makes a git-responding gutter on the sign column
Plug 'jiangmiao/auto-pairs' 		" auto pairs
Plug 'junegunn/goyo.vim'			" Goyo writer focus mode

call plug#end()

"Enabling plug in filetypes
filetype plugin on

" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "

" GENERAL SETTINGS


" Pop-up menu settings (CoC, autocorrect)
set hidden 				" Multiple open buffers
set pumheight=10		" More pop-up menu options

" Side bar settings
set number relativenumber	" Show numbers and relative numbers
set signcolumn=yes			" Show sign column

set encoding=utf-8 fileencoding=utf-8 " File encoding

set cmdheight=2					" Command field height

set iskeyword+=-				" Treat hyphenated words as one

set mouse=a						" Allow mouse usage
set clipboard=unnamedplus		" Copy + paste to system clipboard

" Wrap settings
set nowrap 						" No wrapping by default
set linebreak					" If wrapping enable, don't break words

" Indentation settings
set tabstop=4 softtabstop=4		" Tab size = 4
set shiftwidth=4 				" Shift commands use 4 chars
set expandtab 					" Use spaces not tabs
set autoindent					" Allows auto-indentation

" Search settings
set nohls						" Don't highlight search results
set is							" Ignore case in searches

" Faster completion
set updatetime=300

" Quickens timeout length
set timeoutlen=500

" Spell Language, spell check disabled initially
set nospell spelllang=en_us

" Disable Automatic Comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Nvim file configuration
set undodir="~/.config/nvim/undodir"
set undofile
set noswapfile nobackup nowritebackup


" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "

" NERD TREE CONFIGURATION

nmap <C-n> :NERDTreeToggle<CR>

" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "

" COLOR SETTINGS

syntax on						" Turn on syntax coloring

set termguicolors				" More colors

set background=dark				" EPIC dark mode

set colorcolumn=80				" Colorcolumn at n chars in
set cursorline					" Highlights current cursor line 

" DRACULA CONFIG
let g:dracula_bold		= 1		" Allows bold text 
let g:dracula_inverse	= 1		" Allows inverted text
let g:dracula_italic	= 1		" Allows italic text
let g:dracula_undercurl	= 1		" Allows curly underlines
let g:dracula_underline	= 1		" Allows underlined text


" GRUVBOX CONFIG
let g:gruvbox_bold		= 1		" Allows bold text 
let g:gruvbox_inverse	= 1		" Allows inverted text
let g:gruvbox_italic	= 1		" Allows italic text
let g:gruvbox_undercurl	= 1		" Allows curly underlines
let g:gruvbox_underline	= 1		" Allows underlined text

" ONEDARK CONFIG
let g:onedark_hide_endofbuffer	= 1
let g:onedark_termcolors		= 256
let g:onedark_terminal_bold		= 1
let g:onedark_terminal_italics	= 1

let g:gruvbox_contrast_dark 	= 'soft'	" Dark mode contrast (soft|medium|hard)

colo onedark


" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "


let g:airline_left_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C7"

let g:airline#extensions#tabline#enabled = 1


"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#right_sep = ' '

"let g:airline#extensions#tabline#formatter = 'default'


set noshowmode	" removes default -- INSERT -- and the like


" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "


" WINDOW SPLITTING

function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

" ctrl + hjkl -> move windows or split
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" alt + vim keys resizes window split
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "

" KEYBINDINGS

let mapleader='<space>'

" Goyo keys
nmap <C-g> :Goyo<CR>

" escape keys
inoremap jk <Esc>
vnoremap jk <Esc> 

" save/exit
nnoremap <C-s> :w<CR>
nnoremap <C-q> ZZ
nnoremap <C-x> ZQ

inoremap <C-s> <esc>:w<CR>
inoremap <C-q> <esc>ZZ
inoremap <C-x> <esc>ZQ

nnoremap <M-s> :source ~/.config/nvim/init.vim <CR>
inoremap <M-s> <esc>:source ~/.config/nvim/init.vim <CR>

" TAB and SHIFT-TAB to change buffer
"nnoremap <TAB>   :bnext<CR>
"nnoremap <S-TAB> :bprevious<CR>

" TAB and S-TAB to change tab
nnoremap <TAB> gt
nnoremap <S-TAB> gT

nnoremap <C-t> :tabe<enter>

" Easy Caps
"nnoremap <c-u> viwU<esc>
"inoremap <c-u> <Esc>viwU

" Better visual mode indentation
vnoremap < <gv
vnoremap > >gv

" *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--* "

" AUTO COMMANDS

autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff

autocmd BufRead,BufNewFile *.md,*.txt,*.ms,*.me,*.mom,*.man,*.org set spell wrap colorcolumn=
autocmd BufRead,BufNewFile *.md,*.txt,*.ms,*.me,*.mom,*.man,*.org nnoremap j gj
autocmd BufRead,BufNewFile *.md,*.txt,*.ms,*.me,*.mom,*.man,*.org nnoremap k gk

autocmd BufWritePost config.def.h ![ -f 'config.h' ] && cp config.def.h config.h

" autocmd FileType cpp nnoremap <F5> :w!\|!g++ % -o run.out && echo && time ./run.out; rm -f run.out <enter>

