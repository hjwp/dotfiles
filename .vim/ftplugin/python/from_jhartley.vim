" autocompletion
set omnifunc=pythoncomplete#Complete

" go to next/prev class
map <C-S-PageDown> /^class .*(.*):<cr>z<cr>:noh<cr>
map <C-S-PageUp> 0?^class .*(.*):<cr>z<cr>:noh<cr>

" go to next/prev def
map <C-PageDown> /^\s*def .*(.*):<cr>z<cr>:noh<cr>
map <C-PageUp> 0?^\s*def .*(.*):<cr>z<cr>:noh<cr>


