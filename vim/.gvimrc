set visualbell t_vb=
set guioptions-=T   " no toolbar
set guioptions-=m   " no menubar

if has('win32') || has('win64')
    set guifont=DejaVu\ Sans\ Mono:h9
else
    set guifont=Monofur\ Regular\ 16
endif

" %1 and %2 used in .vimrc statusline are user-defined colors, defined here:
hi User1 guifg=yellow guibg=black
hi User1 ctermfg=yellow ctermbg=black
hi User2 guifg=#000000 guibg=#406080
hi User2 ctermfg=grey 

" increase/decrease font size with - and +
function! FontSmaller()
    if has('win32') || has('win64') || has('mac')
        let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')
    else
        let &guifont = substitute(&guifont, ' \(\d\+\)', '\=" " . (submatch(1) - 1)', '')
    endif
    set guifont
endfunction

function! FontBigger()
    if has('win32') || has('win64') || has('mac')
        let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')
    else
        let &guifont = substitute(&guifont, ' \(\d\+\)', '\=" " . (submatch(1) + 1)', '')
    endif
    set guifont
endfunction

nmap <silent> _ :call FontSmaller()<cr>
nmap <silent> + :call FontBigger()<cr>
