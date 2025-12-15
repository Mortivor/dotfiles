" *********************
" * Plugin Management *
" *********************

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/dotfiles
call vundle#begin()
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'VundleVim/Vundle.vim'
Plugin 'ap/vim-css-color'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'desert256.vim'
Plugin 'elzr/vim-json'
Plugin 'godlygeek/tabular'
Plugin 'https://github.com/airblade/vim-gitgutter.git'
Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mengelbrecht/lightline-bufferline'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'xuyuanp/nerdtree-git-plugin'
call vundle#end()

" *************************
" * Farben & Highlighting *
" *************************

" HTML/Mason-Syntaxhighlighting laden (standardmäßig ist das nicht geladen)
autocmd Syntax mason so $VIMRUNTIME/syntax/mason.vim
" *.m Dateien als HTML/Mason behandeln
autocmd BufNewFile,BufRead *.m set ft=mason
" *.json Dateien als JSON behandeln
autocmd BufNewFile,BufRead *.json set ft=json
" Die GitGutter-Spalte solle einen "normalen" Hintergrund haben. Diese Anweisung muß vor der Auswahl des ColorScheme stehen.
autocmd ColorScheme * highlight! link SignColumn LineNr

colorscheme desert256
syntax on

" ****************
" * Autocomplete *
" ****************

set wildmenu
set wildmode=list:longest,full
set wildignore+=*.git
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.ico,*.class
set wildignore+=*.DS_Store
set wildignore+=*.tmp,*~

" *********
" * Suche *
" *********

" Suchtreffer hervorheben
set hlsearch
" Groß-/Kleinschreibung ignorieren
set ignorecase
" Groß-/Kleinschreibung nur ignorieren wenn der Suchbegriff nur Kleinschreibung enthält
set smartcase
" Suchvorgang schon beim Tippen starten
set incsearch

" *************
" * Sonstiges *
" *************

" Nicht sichtbare Sonderzeichen mit folgenden Zeichen ersetzen (wenn ":set list" gesetzt ist)
let &listchars = "tab:| ,eol:$,trail:•,nbsp:¬"
" Mapleader
let mapleader = ","
" Standardmäßig löscht Backspace nicht über Einrückungen, Zeilenumbrüche und den Punkt an dem der Einfügemodus begann hinaus. Diese Einstellung behebt das.
set backspace=indent,eol,start
" Die Zeile hervorheben, in der sich der Cursor befindet
set cursorline
" Standard-Encoding unter VIM: UTF-8 [wirkt wie 'set encoding=utf-8']
set enc=utf-8
" Standard sind 20 Einträge, wir verlängern die History etwas
set history=500
" kein automatischer Zeilenumbruch
set nowrap
" Zeilennummer anzeigen
set number
" Immer mind. drei Zeilen über und unter dem Cursor zeigen
set scrolloff=3
" für das Einrücken mit Tabs sollte hier der gleiche Wert wie bei 'tabstop' stehen (beeinflusst >> und << und automatisches Einrücken)
set shiftwidth=4
" ein <tab> ist vier Leerzeichen lang
set tabstop=4
" Schnelleres Wechseln zwischen den Modi
set ttimeoutlen=50
" Buffer-Wechsel auch bei nicht-gespeicherten Änderungen
set hidden

" **************************
" * Swap- und Temp-Dateien *
" **************************

" Diese Dateien werden standardmäßig in dem Verzeichnis angelegt in dem die editierte Datei liegt. Wir wollen das lieber zentral haben.

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

" ***************
" * Statuszeile *
" ***************

" Statuszeile immer anzeigen
set laststatus=2
" Nicht anzeigen ob Insert / Normal / anderer Mode. Wird wegen Lightline benötigt damit's nicht doppelt angezeigt wird.
set noshowmode
" Tabline immer anzeigen
set showtabline=2

" ***************
" * Keybindings *
" ***************

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo, so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <F5> :TagbarToggle<CR>
nnoremap <F6> :set list!<CR>
nnoremap <F10> :nohlsearch<CR>
autocmd Filetype xml map <F9> :%!xmllint --format -<CR>
if executable("python3")
	autocmd Filetype json map <F9> :%!python3 -m json.tool<CR>
elseif executable("python2")
	autocmd Filetype json map <F9> :%!python2 -m json.tool<CR>
elseif executable("python")
	autocmd Filetype json map <F9> :%!python -m json.tool<CR>
endif

" Einrückungen per "<" und ">" auch im Visual Mode
vnoremap < <gv
vnoremap > >gv

" Wir suchen "verymagic" (also mit regulären Ausdrücken)
vnoremap / /\v
nnoremap / /\v

" Buffernavigation
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprev<CR>
nnoremap <Leader>bq :bp<CR>:bd#<CR>:redrawstatus!

" Suchtreffer zentrieren
nmap n nzz
nmap N Nzz

" *****************************
" * Einstellungen für Plugins *
" *****************************

" *** NERDTREE

" Fenster etwas größer
let g:NERDTreeWinSize = 42
" Ist NERDTree offen und der letzte "normale" Buffer wird geschlossen, VIM auch schließen
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b.NERDTree.isTabTree()) | q | endif

" *** GitGutter

" Update GitGutter Symbole beim Speichern von Dateien
autocmd BufWritePost * GitGutter
let g:gitgutter_map_keys = 0

" *** CtrlP

" Keine Begrenzung der Dateien in CtrlP
let g:ctrlp_max_files = 0
" Bestimmte Dateien ignorieren
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.git$',
	\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|gif|ico)$'
\ }

" *** VIM-JSON

" Syntaxdetails (z.B. Anführungszeichen) nicht ausblenden
let g:vim_json_syntax_conceal = 0

" *** Lightline

function! LightlineDisplayGitBranch()
	return "\U2387 %{FugitiveHead()}"
endfunction

function! GitStatus()
	let [a,m,r] = GitGutterGetHunkSummary()
	return printf('+%d ~%d -%d', a, m, r)
endfunction

let g:lightline={
	\ 'colorscheme': 'jellybeans',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste'],
	\             [ 'gitbranch', 'gitstatus' ],
	\             [ 'readonly', 'relativepath', 'modified' ] ],
	\   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
	\              [ 'percent', 'lineinfo' ],
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

" *** Bufferline

let g:lightline#bufferline#smart_path=0

" *********************
" * Eigene Funktionen *
" *********************

" funktioniert nicht oO

inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a
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
