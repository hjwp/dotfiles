setlocal shiftwidth=4
setlocal expandtab
setlocal tabstop=4

" switch off fucking smartindent which breaks comments
au! FileType python setl nosmartindent

"automatically strip whitespace from line endings on save
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

" go to next/prev class
map <C-S-PageDown> /^class .*(.*):<cr>z<cr>:noh<cr>
map <C-S-PageUp> 0?^class .*(.*):<cr>z<cr>:noh<cr>

" go to next/prev def
map <C-PageDown> /^\s*def .*(.*):<cr>z<cr>:noh<cr>
map <C-PageUp> 0?^\s*def .*(.*):<cr>z<cr>:noh<cr>


" dontification
nnoremap <Leader>d ma:%s/def test/def DONTtest/g<CR>'a
nnoremap <Leader>D ma:%s/def DONTtest/def test/g<CR>'a

