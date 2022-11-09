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

" Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

"  GENERAL CONFIG
let mapleader = ","

colorscheme tokyonight

" Give more space for displaying messages at the bottom of the screen
set cmdheight=2

" ctrl+v pastes from system buffer
" (user leader+v for visual mode instead)
map <C-v> "+gP

" ,Q as alernative to ctrl+q i just got usd to it
nnoremap <leader>q <C-Q>

" aliases for window switching
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j

" telescope fuzzyfinder
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>h <cmd>Telescope help_tags<cr>



" coc.nvim tab completion
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

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" autoformat with f9
noremap <F9> :call CocAction('format')<CR>
