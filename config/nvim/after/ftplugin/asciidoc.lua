-- my own customisations for asciidoc
--

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_gb"

-- old book
vim.cmd('iab <buffer> cmdg [subs="specialcharacters,quotes"]<Enter>----<Enter>$ *git')
vim.cmd(
    'iab <buffer> srcp <Enter>[role="sourcecode"]<Enter>.src/lists/thing.py (ch04l004)<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter><Up><Up>')


vim.keymap.set(
    "v", "<F9>", ":!ruff format -q -<CR>",
    { buffer = true })
vim.keymap.set(
    "n", "<F10>", "s/'/\"/g<CR>",
    { buffer = true })
vim.keymap.set(
    "n", "<F8>", ":s/)))/)))\\r/g<CR><BS>",
    { buffer = true })
vim.keymap.set(
    "n", "<F7>", ":s:\\/\\(Users\\|home\\).\\+harry.\\+workspace.\\+superlists\\/:...goat-book/:<CR>",
    { buffer = true })
vim.keymap.set(
    "n", "<F6>", ":s/.home.harry.\\+.venv.\\+site-packages/.../<CR>",
    { buffer = true })

vim.keymap.set(
    "n", "<leader>t", "/TODO\\|HARRY\\|RITA\\|XUAN\\|DAVID\\|CSANAD\\|SEBASTIAN\\|\\<JAN\\><CR>",
    { buffer = true })
--
-- "snippets for new book
-- "iab <buffer> srcp <Enter>[[id_here]]<Enter>.Listing title<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter><Up><Up>
-- iab <buffer> srci <Enter>++++<Enter><!-- IMAGE SOURCE<Enter>[ditaa, image_id]<Enter>....<Enter><Enter>....<Enter>--><Enter>++++<Enter>
--
-- "snippets for old book
-- iab <buffer> srcp <Enter>[role="sourcecode"]<Enter>.lists.tests.py (ch04l004)<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter><Up><Up>
-- iab <buffer> srch [role="sourcecode"]<Enter>.lists/templates/home.html<Enter>[source,html]<Enter>----<Enter>
-- iab <buffer> cmdg [subs="specialcharacters,quotes"]<Enter>----<Enter>$ *git
-- iab <buffer> cmdt [subs="specialcharacters,macros"]<Enter>----<Enter>$ pass:quotes[*python3 manage.py test lists*]
--
--
--
-- " snippets for tddwp
-- iab <buffer> srcp [role="sourcecode"]<Enter>.lists/tests.py (ch00l000)<Enter>====<Enter>[source,python]<Enter>----<Enter><Enter>----<Enter>====<Enter>
-- iab <buffer> srch [role="sourcecode"]<Enter>.lists/templates/home.html (ch00l000)<Enter>====<Enter>[source,html]<Enter>----<Enter><Enter>----<Enter>====<Enter>
-- iab <buffer> cmdg [subs="specialcharacters,quotes"]<Enter>----<Enter>$ *git
-- iab <buffer> cmdt [subs="specialcharacters,macros"]<Enter>----<Enter>$ pass:quotes[*python3 manage.py test lists*]
--
-- "snippets for new book
-- " iab <buffer> srcp <Enter>[[id_here]]<Enter>.Listing title<Enter>====<Enter>[source,python]<Enter>----<Enter>----<Enter>====<Enter>
-- " iab <buffer> srci <Enter>++++<Enter><!-- IMAGE SOURCE<Enter>[ditaa, image_id]<Enter>....<Enter><Enter>....<Enter>--><Enter>++++<Enter>
