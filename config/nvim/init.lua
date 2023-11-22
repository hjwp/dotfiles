

-- general vim options / config --

vim.opt.nu = true  -- line numbers on

vim.g.mapleader = "," -- mapleader has to be before lazy so mappings are correct

-- sane tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- infinite undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- no need for swapfiles
vim.opt.swapfile = false

-- highlight matching words as you search
vim.opt.incsearch = true


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
   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000, -- has to be loaded early if its the default scheme
   },
   {
      "nvim-telescope/telescope.nvim", tag = "0.1.4",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function ()
         local builtin = require("telescope.builtin")
         vim.keymap.set("n", "<leader>f", builtin.find_files, {})
         vim.keymap.set("n", "<leader>b", builtin.buffers, {})
         vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
      end
   },
   {
      "nvim-treesitter/nvim-treesitter",
      config = function ()
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
      "VonHeikemen/lsp-zero.nvim",
      branch = "v3.x",
      dependencies = {
         {"neovim/nvim-lspconfig"},
         -- auto-lsp installation+config
         {"williamboman/mason.nvim"},
         {"williamboman/mason-lspconfig.nvim"},
         -- Autocompletion
         {"hrsh7th/nvim-cmp"},
         {'hrsh7th/cmp-nvim-lsp'},
         -- generic language server wrapper for normal linters
         {
            'creativenull/efmls-configs-nvim',
            version = 'v1.x.x',
         },
      },
      config = function ()
         local lsp_zero = require("lsp-zero")
         require("mason").setup()
         require("mason-lspconfig").setup({
            ensure_installed = {},
            handlers = {lsp_zero.default_setup},
         })
         lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
         end)
         lsp_zero.setup()

         local cmp = require('cmp')

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
            markdown = { require('efmls-configs.linters.markdownlint') },
            python = { require('efmls-configs.linters.mypy')},
         }
         require('lspconfig').efm.setup({
            filetypes = vim.tbl_keys(languages),
            settings = {
               rootMarkers = { '.git/' },
               languages = languages,
            },
         })
      end,
   },
   {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function ()
         vim.keymap.set("n", "<leader>d", function() require("trouble").toggle() end)
      end
   },
})

vim.cmd.colorscheme("habamax")

