set nocompatible
filetype off

" *********************************************************************
" * Identifikation des OS (wichtig für ein paar Fallunterscheidungen) *
" *********************************************************************

if substitute(system("which sw_vers"), "\n", "", "") != ""
	let s:os = "macos"
elseif substitute(system("lsb_release"), "\n", "", "") != ""
	let s:os = "linux"
endif

" *************************
" * Farben & Highlighting *
" *************************

autocmd Syntax mason so $VIMRUNTIME/syntax/mason.vim
autocmd BufNewFile,BufRead *.m set ft = mason
autocmd BufNewFile,BufRead *.json set ft = json

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

map <F4> :NERDTreeToggle<CR>
map <F5> :TagbarToggle<CR>
map <F6> :set list!<CR>
map <F10> :nohlsearch<CR>

" Einrückungen per "<" und ">" auch im Visual Mode
vnoremap < <gv
vnoremap > >gv

" Wir suchen "verymagic" (also mit regulären Ausdrücken)
vnoremap / /\v
nnoremap / /\v

" Buffernavigation
nmap <Leader>l :bnext<CR>
nmap <Leader>h :bprev<CR>
nmap <Leader>bq :bp<BAR>bd #<CR>

" Suchtreffer zentrieren
nmap n nzz
nmap N Nzz
