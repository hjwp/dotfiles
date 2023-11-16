" my own customisations for asciidoc

setlocal spell
setlocal spelllang=en_gb

" 2 spaces indention
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

"snippets for new book
" iab <buffer> srcp <Enter>[[id_here]]<Enter>.Listing title<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter><Up><Up>
iab <buffer> srci <Enter>++++<Enter><!-- IMAGE SOURCE<Enter>[ditaa, image_id]<Enter>....<Enter><Enter>....<Enter>--><Enter>++++<Enter>

"snippets for old book
iab <buffer> srcp <Enter>[role="sourcecode"]<Enter>.lists.tests.py (ch04l004)<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter><Up><Up>
iab <buffer> srch [role="sourcecode"]<Enter>.lists/templates/home.html<Enter>[source,html]<Enter>----<Enter>
iab <buffer> cmdg [subs="specialcharacters,quotes"]<Enter>----<Enter>$ *git
iab <buffer> cmdt [subs="specialcharacters,macros"]<Enter>----<Enter>$ pass:quotes[*python3 manage.py test lists*]

vnoremap <F9> :!black -q -<CR>
noremap <F10> :s/'/"/g<CR>
noremap <F8> :s/)))/)))\r/g<CR>
noremap <F7> :s/.home.harry.dropbox.\+superlists/...goat-book/<CR>
noremap <F6> :s/.home.harry.\+.venv.\+site-packages/.../<CR>

