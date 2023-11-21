set visualbell t_vb=
set guioptions-=T   " no toolbar
set guioptions-=m   " no menubar

if has('win32') || has('win64')
    set guifont=monofur\ for\ Powerline:h12
elseif has('macunix')
    set guifont=Inconsolata\ for\ Powerline:h12
else
    set guifont=monofur\ for\ Powerline 14
endif

" GUI is running or is about to start.
" Maximize gvim window.
set lines=40 columns=180


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
