" Set JavaScript Lint as compiler. 
if ! exists('b:current_compiler') 
    compiler jsl 
endif 

" no clever indenting - nothing is clever enough to handle javascript
setlocal autoindent
setlocal indentexpr=

