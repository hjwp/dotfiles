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
    pattern = { "markdown", "asciidoc", "html", "javascript" },
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

-- search
vim.opt.incsearch = true  -- highlight matching words as you search
vim.opt.ignorecase = true -- case-insenstive search...
vim.opt.smartcase = true  -- ... unless there"s mixed case

-- COPY/PASTE SETTINGS

-- share clipbloard with system
vim.opt.clipboard = "unnamedplus"

-- otherwise neovide breaks cmd+c/v
vim.g.neovide_input_use_logo = 1
--

vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<CR>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<CR>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<CR>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-c>', '"+y<CR>', { noremap = true, silent = true })

-- termguicoors makes true-color themes work in iterm2
vim.opt.termguicolors = true

-- Give more space for displaying messages at the bottom of the screen
vim.opt.cmdheight = 2


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
                vim.keymap.set("n", "<CR>", vim.lsp.buf.format)
                vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename)
                vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
                vim.keymap.set("n", "<leader>t", vim.lsp.buf.definition)
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
            local languages = {
                markdown = { require("efmls-configs.linters.markdownlint") },
                python = { require("efmls-configs.linters.mypy") },
            }
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
            vim.keymap.set("n", "<leader>d", function() require("trouble").toggle() end)
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
            -- <leader>r is also defined earlier for rename, it does not need this extra plugin
        end,
    },

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

-- trim whitespace
vim.keymap.set("n", "<Leader>e", ":%s/\\s\\+$//e<CR>")


-- aliases for window switching
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- un-highlight search results
vim.keymap.set("n", "<leader-s>", vim.cmd.nohlsearch)

-- close window
vim.keymap.set("n", "<BS>", vim.cmd.bdelete)

if vim.g.neovide then
    vim.o.guifont = "Lekton Nerd Font:h14"
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
