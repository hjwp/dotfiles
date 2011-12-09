" Set JavaScript Lint as compiler. 
if ! exists('b:current_compiler') 
    compiler jsl 
endif 

" 2 spaces for tabs
setlocal shiftwidth=2
setlocal tabstop=2

" no clever indenting - nothing is clever enough to handle javascript
setlocal autoindent
setlocal indentexpr=
