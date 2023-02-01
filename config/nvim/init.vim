call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fuzzy-finder
Plug 'nvim-telescope/telescope.nvim'

" required for telescope.vim
Plug 'nvim-lua/plenary.nvim'

" better syntax highlighter, also linked to telescope.vim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" colour schemes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" not working at time of writing
Plug 'kylechui/nvim-surround'


" syntax-highlight Roc as markdown
Plug 'kchmck/vim-coffee-script'
autocmd BufNewFile,BufRead *.roc :setfiletype coffee

" Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

"  GENERAL CONFIG
let mapleader = ","

colorscheme tokyonight

"switch on line numbers
set number

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" map key to dismiss search highlightedness
map <BS> :noh<CR>

" python / general tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " convert all typed tabs to spaces

" Give more space for displaying messages at the bottom of the screen
set cmdheight=2

" ctrl+v pastes from system buffer
" like any normal app!
" (user leader+v for visual mode instead)
map <C-v> "+gP

" shift plus movement keys changes selection
" again, like a normal app!
set keymodel=startsel,stopsel

" ctrl+c copies to system pastebuffer
" (use with arrow key selection above)
vnoremap <C-c> "+y

" trim whitespace
nmap <Leader>e :%s/\s\+$//e<CR>

" ,Q as alernative to ctrl+q i just got usd to it
nnoremap <leader>q <C-Q>

" move up/down by visible lines on long wrapped lines of text
nnoremap k gk
nnoremap j gj

" aliases for window switching
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j

" telescope fuzzyfinder
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope grep_string<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>h <cmd>Telescope help_tags<cr>



" coc.nvim tab completion

" helper
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ctrl+space triggers completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a  <Plug>(coc-codeaction-selected)<CR>

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" autoformat with f9
noremap <F9> :call CocAction('format')<CR>

" go to definition
nmap <silent> <leader>t <Plug>(coc-definition)

" Use K to show documentation in preview window
" (eg show type of variable under cursor)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" navigate diagnostics
noremap <leader>d :CocDiagnostics<CR>
noremap <F3> <Plug>(coc-diagnostic-next)
" noremap <F4> <Plug>(coc-diagnostic-prev)

