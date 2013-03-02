" autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete

setlocal shiftwidth=4
setlocal expandtab
setlocal tabstop=4

" switch off fucking smartindent which breaks comments
au! FileType python setl nosmartindent

" add tags for python core and django, if available
set tags+=$HOME/.vim/tags/python.ctags
set tags+=$HOME/.vim/tags/django.ctags

"config for python.vim advanced syntax highlighter (vim.org #790)
"let python_highlight_all = 1

"automatically strip whitespace from line endings on save
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

" go to next/prev class
map <C-S-PageDown> /^class .*(.*):<cr>z<cr>:noh<cr>
map <C-S-PageUp> 0?^class .*(.*):<cr>z<cr>:noh<cr>

" go to next/prev def
map <C-PageDown> /^\s*def .*(.*):<cr>z<cr>:noh<cr>
map <C-PageUp> 0?^\s*def .*(.*):<cr>z<cr>:noh<cr>


" dontification
nnoremap <Leader>d :%s/def test/def DONTtest/g<CR>
nnoremap <Leader>D :%s/def DONTtest/def test/g<CR>
