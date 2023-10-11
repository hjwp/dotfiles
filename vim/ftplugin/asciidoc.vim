" my own customisations for asciidoc

setlocal spell

" " US spelling sigh
" setlocal spelllang=en_us


vnoremap <F9> :!black -q -<CR>
noremap <F10> :s/'/"/g<CR>
noremap <F8> :s/)))/)))\r/g<CR>

" snippets for tddwp 
iab <buffer> srcp [role="sourcecode"]<Enter>.lists/tests.py<Enter>[source,python]<Enter>----<Enter>
iab <buffer> srch [role="sourcecode"]<Enter>.lists/templates/home.html<Enter>[source,html]<Enter>----<Enter>
iab <buffer> cmdg [subs="specialcharacters,quotes"]<Enter>----<Enter>$ *git
iab <buffer> cmdt [subs="specialcharacters,macros"]<Enter>----<Enter>$ pass:quotes[*python3 manage.py test lists*]

"snippets for new book
" iab <buffer> srcp <Enter>[[id_here]]<Enter>.Listing title<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter>
" iab <buffer> srci <Enter>++++<Enter><!-- IMAGE SOURCE<Enter>[ditaa, image_id]<Enter>....<Enter><Enter>....<Enter>--><Enter>++++<Enter>

