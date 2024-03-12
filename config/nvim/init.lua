-- general vim options / config --

vim.opt.nu = true     -- line numbers on

vim.g.mapleader = "," -- mapleader has to be before lazy so mappings are correct

-- sane tabs.  4 by default, 2 for some types
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "asciidoc", "html", "htmldjango", "javascript" },
    callback = function(_)
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

-- infinite undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- swapfiles cause more pain than they prevent.... i think?
vim.opt.swapfile = false


-- auto-reload files that have changed on disk
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
    command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
    pattern = { "*" },
})

-- search
vim.opt.incsearch = true  -- highlight matching words as you search
vim.opt.ignorecase = true -- case-insenstive search...
vim.opt.smartcase = true  -- ... unless there"s mixed case

-- COPY/PASTE SETTINGS

-- share clipbloard with system
vim.opt.clipboard = "unnamedplus"

-- otherwise neovide breaks cmd+c/v
vim.g.neovide_input_use_logo = 1

-- cmd+c in visual mode, yank to special + buffer (= system clipboard)
vim.api.nvim_set_keymap("v", "<D-c>", '"+y', { noremap = true, silent = true })

-- cmd+v in all applicable modes pastes the special + buffer, via vim api
vim.keymap.set(
    { 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' },
    '<D-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
)


-- termguicoors makes true-color themes work in iterm2
vim.opt.termguicolors = true

-- Give more space for displaying messages at the bottom of the screen
vim.opt.cmdheight = 2

-- shortcut for visual block mode, helpful on non-macs.
vim.api.nvim_set_keymap("n", "<Leader>q", "<C-v>", { noremap = true, silent = true })

-- jj to escape insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- helper fn for tab-completion
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    -- colour schemes
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },
    { "sainnhe/everforest" },
    { "sainnhe/sonokai" },
    { "savq/melange-nvim" },
    { "EdenEast/nightfox.nvim" },

    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>f", builtin.find_files, {})
            vim.keymap.set("n", "<leader>b", builtin.buffers, {})
            vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
        end
    },

    -- fancy syntax highlighter thingie
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query", "python"
                },
                auto_install = true,
                sync_install = false,
                highlight = { enable = true }
            }
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
        config = function()
            require("Comment").setup()
            -- Toggle current line (linewise) using C-/
            local api = require("Comment.api")
            vim.keymap.set('n', '<D-/>', api.toggle.linewise.current)
            vim.keymap.set('v', '<D-/>', api.toggle.linewise.current)
        end
    },
    -- surround motions
    {
        "kylechui/nvim-surround",
        version = "*", -- for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- MONSTER LSP CONFIG BLOCK
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            -- auto-lsp installation+config
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "PaterJason/cmp-conjure" },

            -- generic language server wrapper for normal linters
            {
                "creativenull/efmls-configs-nvim",
                version = "v1.x.x",
            },

        },
        config = function()
            local lsp_zero = require("lsp-zero")
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            settings = {
                                Lua = { diagnostics = { globals = { "vim" } }, },
                            }
                        })
                    end,
                },
            })
            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                local ts_builtin = require("telescope.builtin")
                vim.keymap.set('n', 'gr', ts_builtin.lsp_references, { buffer = bufnr })
                vim.keymap.set("n", "<S-CR>", vim.lsp.buf.format)
                vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename)
                vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
                vim.keymap.set("n", "<leader>t", vim.lsp.buf.definition)
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
            end)
            lsp_zero.setup()

            -- diagnostic icons in gujtter
            local signs = { Error = "‼️", Warn = "⚠️", Hint = "💡", Info = "ℹ️" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            local cmp = require("cmp")

            cmp.setup({
                completion = {
                    autocomplete = false -- otherwise autocomplete triggers on every keystroke
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'conjure' },
                }, {
                    { name = 'buffer' },
                }),
                mapping = cmp.mapping.preset.insert({
                    -- try to make tab-completion work.
                    -- from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
                    -- tab = start completion if not started, or scroll thru options, or select
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                })
            })

            -- efm (generic linter lsp wrapper) config
            --
            --
            local languages = require('efmls-configs.defaults').languages()
            languages = vim.tbl_extend('force', languages, {
                markdown = {
                    require("efmls-configs.linters.markdownlint"),
                    require('efmls-configs.formatters.prettier'),
                },
                -- python = { require("efmls-configs.linters.mypy") },
            })
            require("lspconfig").efm.setup({
                filetypes = vim.tbl_keys(languages),
                settings = {
                    rootMarkers = { ".git/" },
                    languages = languages,
                },
            })
        end,
    },
    -- nice diagnostics view thing
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<leader>d", function()
                require("trouble").toggle("document_diagnostics")
            end)
        end
    },
    -- refactoring
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
            vim.keymap.set("x", "<leader>re", ":Refactor extract ")
            vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
            vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
            vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
            vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
            vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
            vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
            vim.keymap.set(
                { "n", "x" },
                "<leader>rr",
                function() require('refactoring').select_refactor() end
            )
            -- <leader>n is also defined earlier for rename, it does not need this extra plugin
        end,
    },

    -- repl integration for lips/scheme (but also maybe python??)
    {
        "Olical/conjure",
        config = function()
            -- default mapping for this is K but i use that for lsp reveal type
            vim.g["conjure#mapping#doc_word"] = "gk"
            require("conjure.main").main()
            require("conjure.mapping")["on-filetype"]()
            -- this should be Shift-E but keybindings aren't loading by default for some reason
            vim.keymap.set("v", "<space>e", ":ConjureEvalVisual<CR>")
        end,
    },

    -- our Microsoft AI friend...
    {
        "github/copilot.vim",
        config = function()
            -- explicitly point at v18 of node incase we've activated an older version.
            vim.g.copilot_node_command = { "fnm", "exec", "--using=v18", "node" }

            -- Tab already used in cmp setup above
            vim.g.copilot_no_tab_map = true

            -- Request suggestions manually:
            -- first, disable by default
            -- vim.g.copilot_filetypes = {["*"] = false}

            -- (NB on MacOS, need to turn off default ctrl+space keybinding)
            -- vim.keymap.set('i', '<C-Space>', 'copilot#Suggest()', {
            --     expr = true,
            --     replace_keycodes = false,
            -- })

            -- Accept current suggestion with ctrl+enter
            vim.keymap.set('i', '<C-Enter>', 'copilot#Accept("")', {
                expr = true,
                replace_keycodes = false
            })
            -- Ctrl+e is what i use in zsh so it's in muscle memory
            vim.keymap.set('i', '<C-e>', 'copilot#Accept("")', {
                expr = true,
                replace_keycodes = false
            })
        end,
    },
    -- coffeescript isnt built-in
    -- (using this for roc)
    { "kchmck/vim-coffee-script" },

    -- { "habamax/vim-asciidoctor" },  -- tried this but it's worse than builtin
})

-- Initialize the random number generator
math.randomseed(os.time())
math.random(); math.random(); math.random()


local all_schemes = vim.fn.getcompletion("", "color")
local random_colorscheme = function()
    return all_schemes[math.random(#all_schemes)]
end

vim.cmd.colorscheme(random_colorscheme())



------- GENERAL KEYMAPS -----

-- random scheme
vim.keymap.set("n", "<leader>c", function()
    local cs = random_colorscheme()
    vim.cmd.colorscheme(cs)
    print(cs)
end)

-- open some common files
vim.keymap.set("n", "<space>c", ":e $MYVIMRC<CR>")
vim.keymap.set("n", "<space>t", ":e ~/Documents/todos-work.md<CR>")
vim.keymap.set("n", "<space>d", ":e ~/Documents/diary.md<CR>")

-- trim whitespace
vim.keymap.set("n", "<Leader>e", ":%s/\\s\\+$//e<CR>")


-- aliases for window switching
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- un-highlight search results
vim.keymap.set("n", "<BS>", vim.cmd.nohlsearch)

-- hide diagnostics
-- TODO: does not work in terminal vim
vim.keymap.set("n", "<D-BS>", vim.diagnostic.hide)


local GUIFONT = "Lekton Nerd Font"

local current_guifont_size = function()
    return tonumber(string.match(vim.o.guifont, ".+:h(%d+)"))
end
local embiggen_font = function()
    local new_size = ":h" .. (current_guifont_size() + 2)
    vim.opt.guifont = { GUIFONT, new_size }
end
local smallize_font = function()
    local new_size = ":h" .. (current_guifont_size() - 2)
    vim.opt.guifont = { GUIFONT, new_size }
end

if vim.g.neovide then
    vim.opt.guifont = { GUIFONT, ":h14" }
    vim.keymap.set('n', '<D-=>', embiggen_font, { noremap = true, silent = true })
    vim.keymap.set('n', '<D-->', smallize_font, { noremap = true, silent = true })

    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.remember_window_size = true
end
