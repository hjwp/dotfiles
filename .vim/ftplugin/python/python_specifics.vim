" autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete

"automatically strip whitespace from line endings on save
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

" go to next/prev class
map <C-S-PageDown> /^class .*(.*):<cr>z<cr>:noh<cr>
map <C-S-PageUp> 0?^class .*(.*):<cr>z<cr>:noh<cr>

" go to next/prev def
map <C-PageDown> /^\s*def .*(.*):<cr>z<cr>:noh<cr>
map <C-PageUp> 0?^\s*def .*(.*):<cr>z<cr>:noh<cr>


