set nocompatible
filetype off

"
" Plugin Management
"

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/dotfiles
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dense-analysis/ale'
Plugin 'desert256.vim'
Plugin 'elzr/vim-json'
Plugin 'garbas/vim-snipmate'
Plugin 'godlygeek/tabular'
Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'maximbaz/lightline-ale'
Plugin 'mengelbrecht/lightline-bufferline'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'ap/vim-css-color'

call vundle#end()

"
" Farben & Highlighting
"

function! GetMasonSyntaxFilePath()
	return system("dpkg -S vim | grep mason.vim | cut -d' ' -f2")
endfunction

autocmd Syntax mason so echo GetMasonSyntaxFilePath()
autocmd BufNewFile,BufRead *.m set ft=mason
autocmd BufNewFile,BufRead *.json set ft=json
autocmd BufWritePost * GitGutter
autocmd ColorScheme * highlight! link SignColumn LineNr

if !has('gui_running')
	set t_co=256
endif
try
	colorscheme desert256
catch
endtry
syntax on

"
" Autocomplete
"

set wildmenu
set wildmode=list:longest,full
set wildignore+=*.git
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.ico,*.class
set wildignore+=*.DS_Store
set wildignore+=*.tmp,*~

"
" Suche
"

set hlsearch
set ignorecase
set incsearch
set smartcase

"
" Sonstiges
"

let &listchars="tab:| ,eol:$,trail:\u2022,nbsp:\u00d7"
let mapleader=","
set backspace=indent,eol,start
set cursorline
set enc=utf-8
set history=500
set nowrap
set number
set scrolloff=3
set shiftwidth=4
set tabstop=4
set ttimeoutlen=50

"
" Swap- und Temp-Dateien
"

set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap

if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), 'p')
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), 'p')
endif

"
" Statuszeile (lightline)
"

set laststatus=2
set noshowmode
set hidden
set showtabline=2

function! LightlineDisplayGitBranch()
	return "\U2387 %{FugitiveHead()}"
endfunction

function! GitStatus()
	let [a,m,r] = GitGutterGetHunkSummary()
	return printf('+%d ~%d -%d', a, m, r)
endfunction

let g:lightline={
	\ 'colorscheme': 'PaperColor',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste'],
	\             [ 'gitbranch', 'gitstatus', 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
	\              [ 'lineinfo' ],
	\              [ 'percent' ],
	\              [ 'charhexvalue', 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'tabline': {
	\   'left': [ ['buffers'] ],
	\ },
	\ 'component_expand': {
	\   'buffers': 'lightline#bufferline#buffers',
	\   'linter_checking': 'lightline#ale#checking',
	\   'linter_infos': 'lightline#ale#infos',
	\   'linter_warnings': 'lightline#ale#warnings',
	\   'linter_errors': 'lightline#ale#errors',
	\   'linter_ok': 'lightline#ale#ok'
	\ },
	\ 'component_type': {
	\   'buffers': 'tabsel',
	\   'linter_errors': 'error',
	\   'linter_ok': 'right',
	\   'linter_checking': 'right',
	\   'linter_infos': 'right',
	\   'linter_warnings': 'warning'
	\ },
	\ 'component': {
	\   'charhexvalue': '0x%B',
	\   'gitbranch': LightlineDisplayGitBranch(),
	\   'gitstatus': "%{GitStatus()}"
	\ },
\ }

"
" CtrlP
"

let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore={
	\ 'dir': '\v[\/]\.git$',
	\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|gif|ico)$'
\ }

"
" Tabular
"

function! s:align()
	let p = '^\s*|\s.*\s|\s*$'
	if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
		let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
		let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
		Tabularize/|/l1
		normal! 0
		call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
	endif
endfunction

"
" GitGutter
"

let g:gitgutter_map_keys=0

"
" Vim-JSON
"

let g:vim_json_syntax_conceal=0

"
" Snipmate
"

let g:snipMate={
	\ 'snippet_version': 1
\ }

"
" Fugitive
"

au FileType fugitiveblame filetype plugin indent on

"
" NERDTree
"

let g:NERDTreeWinSize=42
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b.NERDTree.isTabTree()) | q | endif

"
" Ale
"

let g:ale_linters={
	\ 'perl': ['perl', 'perlcritic'],
\ }
let g:ale_perl_perl_options='-c -Mstrict -Mwarnings -Ilib -Imodules'

"
" Keybindings
"

autocmd Filetype xml map <F9> :%!xmllint --format -<CR>
inoremap <C-U> <C-G>u<C-U>
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a
map <F4> :NERDTreeToggle<CR>
map <F5> :TagbarToggle<CR>
map <F6> :set list!<CR>
nmap <Leader>bq :bp<BAR>bd #<CR>
nmap <Leader>h :bprevious<CR>
nmap <Leader>l :bnext<CR>
vnoremap < <gv
vnoremap > >gv
if executable('python3')
	autocmd Filetype json map <F9> :%!python3 -m json.tool<CR>
elseif executable('python2')
	autocmd Filetype json map <F9> :%!python2 -m json.tool<CR>
elseif executable('python')
	autocmd FileType json map <F9> :%!python -m json.tool<CR>
endif
