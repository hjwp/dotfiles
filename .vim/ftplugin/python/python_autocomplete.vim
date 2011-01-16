"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal omnifunc=pysmell#Complete
set tags+=$HOME/.vim/tags/python.ctags
set tags+=$HOME/.vim/tags/django.ctags
let python_highlight_all = 1

" go to next/prev class
map <C-PageDown> /^class .*(.*):<cr>z<cr>
map <C-PageUp> ?^class .*(.*):<cr>z<cr>

" go to next/prev def
map <S-PageDown> /^\s*def .*(.*):<cr>z<cr>
map <S-PageUp> k?^\s*def .*(.*):<cr>z<cr>

