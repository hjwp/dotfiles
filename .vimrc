color desert
" must be first, changes behaviour of other settings
set nocompatible

" mouse and keyboard selections enter select mode, ctrl-q enters visual mode
set selectmode=mouse,key

" right mouse button extends selection instead of context menu
set mousemodel=extend

" shift plus movement keys changes selection
set keymodel=startsel,stopsel

" allow cursor to be positioned one char past end of line
" and apply operations to all of selection including last char
set selection=exclusive

" allow backgrounding buffers without writing them
" and remember marks/undo for backgrounded buffers
set hidden

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" map cut & paste to what they bloody should be
vnoremap <C-c> "+y
vnoremap <C-x> "+x
map <C-v> "+gP

" ctrl-s to save
map <C-s> :w<CR>
map! <C-s> <Esc>:w<CR>

" make tab completion for files/buffers act like bash
set wildmenu

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Make backups in a single central place.
" Ending in double backslash makes name of temp files include path, thus
" allowing backups to be made of two files edited with same filename.
set backupdir=~/.vim/backups//
set directory=~/.vim/backups//
set backup

" display cursor co-ords at all times
set ruler
set cursorline

" display number of selected chars, lines, or size of blocks.
set showcmd

" highlight last search matches
set hlsearch
" search-next wraps back to start of file
set wrapscan

" show matching brackets, etc, for 1/10th of a second
set showmatch
set matchtime=1

" use 'comma' prefix for multi-stroke keyboard mappings
let mapleader = ","

" enables filetype specific plugins
filetype plugin on
" enables filetype detection
filetype on

if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

else
    " if old vim, set vanilla autoindenting on
    set autoindent

endif " has("autocmd")

" sane text files
set fileformat=unix
set encoding=utf-8

" sane editing
set tabstop=4
set shiftwidth=4
set softtabstop=4

" convert all typed tabs to spaces
set expandtab
" always show status line
set laststatus=2
" custom status line
set statusline=
set statusline+=%<\                           " truncate over-long text here
set statusline+=%f\                           " filename, relative to cwd
set statusline+=%1*%M%*\                      " modified flag in usercolor1
set statusline+=%#StatusLine#\                " restore color
set statusline+=%R%W\                         " read-only & preview flag
set statusline+=buf%n\                        " buffer number
set statusline+=%{strlen(&ft)?&ft:'none'}\    " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}\  " encoding
set statusline+=%{&ff}\                       " fileformat (line endings)
set statusline+=%=\                           " right-align
set statusline+=%b,0x%02B\                    " current char
set statusline+=%c,%l/                        " column,line/
set statusline+=%L\                           " lines in file
set statusline+=%P                            " percent through file

" line numbers
set number

" show search matches as the search pattern is typed
set incsearch
" map key to dismiss search highlightedness
map <bs> :noh<CR>

" grep for word under cursor
map <Leader>g :grep -rw '<C-r><C-w>' .<CR>
" stop pyflakes from polluting the copen quickfix pane
let g:pyflakes_use_quickfix = 0
" map F3 to search jump thru grep results from copen
map <F3> :cnext<CR>

" when joining lines, don't insert two spaces after punctuation
set nojoinspaces

" don't wrap long lines, but display them as wrapped.
"set textwidth=0
"set wrap
" wrap at exactly char 80, not at space chars, etc.
"set nolinebreak
" no line wrapping
set nowrap

" allow cursor keys to go right off end of one line, onto start of next
set whichwrap+=<,>,[,]


" enable automatic yanking to and pasting from the selection
set clipboard+=unnamed

" tags for syntax highlighting
syntax on
"make sure highlighting works all the way down long files
autocmd BufEnter * :syntax sync fromstart
"json...
au! BufRead,BufNewFile *.json setfiletype json
au! Syntax json source ~/.vim/syntax/json.vim
" places to look for tags files:
set tags=./tags,tags
" recursively search file's parent dirs for tags file
" set tags+=./tags;/
" recursively search cwd's parent dirs for tags file
set tags+=tags;/

" generate tags for all files in the current dir (recursive on subdirs)
"map <f12> :!start /min ctags -R --exclude=build .<cr>
map <f12> :!ctags -R --exclude=build .<cr>
map <f11> :!pysmell .<cr>

"autocompletion
inoremap <c-space> <c-n>
inoremap <c-s-space> <c-p>

"remap jj to escape in insert mode.
inoremap jj <Esc>



" files to hide in directory listings
let g:netrw_list_hide='\.py[oc]$,\.svn/$,\.git/$,\.hg/$'
" I don't like folded regions
set nofoldenable
" map sudo-write-file to w!!
cmap w!! %!sudo tee > /dev/null %


" fuzzyfind plugin

let s:extension = '\.bak|\.dll|\.exe|\.o|\.pyc|\.pyo|\.swp|\.swo'
let s:dirname = 'build|deploy|dist|vms|\.bzr|\.git|\.hg|\.svn|.+\.egg-info'

let s:slash = '[/\\]'
let s:startname = '(^|'.s:slash.')'
let s:endname = '($|'.s:slash.')'

let g:fuf_file_exclude = '\v'.'('.s:startname.'('.s:dirname.')'.s:endname.')|(('.s:extension.')$)'
let g:fuf_dir_exclude = '\v'.s:startname.'('.s:dirname.')'.s:endname
let g:fuf_enumeratingLimit = 60

nnoremap <Leader>f :FufFile **/<cr>
nnoremap <Leader>b :FufBuffer<cr>
nnoremap <Leader>t :FufTag<cr>

