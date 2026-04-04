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

local plugins = {
    --"p00f/nvim-ts-rainbow", -- rainbow {}
    "folke/snacks.nvim", -- snacks
    {
        "lukas-reineke/indent-blankline.nvim", --indent blankline
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    {
    "catgoose/nvim-colorizer.lua",
    	event = "BufReadPre",
    	opts = {},
		},
		"folke/tokyonight.nvim", -- tokyonight theme
    "catppuccin/nvim",  --catppucin theme
    "xiyaowong/transparent.nvim",
    "nvim-lualine/lualine.nvim",  -- dock status
    "nvim-tree/nvim-tree.lua",  -- as name
    "nvim-tree/nvim-web-devicons", -- tree icon
    "christoomey/vim-tmux-navigator", -- ctl-hjkl
		{
        "RRethy/base16-nvim",
        lazy = false, -- 确保主题在启动时尽早加载
        priority = 1000,
    },
    -- [已修正] 唯一的 Treesitter 配置，包含安全调用
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- 使用 pcall 安全调用，防止插件还没下载完就报错
            local status, configs = pcall(require, "nvim-treesitter.configs")
            if not status then 
                return 
            end

            configs.setup({
                ensure_installed = { 
                    "lua", "vim", "vimdoc", "query", "rust", 
                    "cpp", "python", "glsl", "bash", "markdown", "markdown_inline" 
                },
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
            require('nvim-treesitter.install').compilers = { "gcc" } 
        end,
    },
    
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        opts = {},
    },
    "sphamba/smear-cursor.nvim",
    
    -- [已清理重复项] 1. Mason 基础架构
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },

    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    -- 2. 自动化安装器
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "lua-language-server",
                    "rust-analyzer",
                    "pyright",
                    "clangd",
                    "jdtls",
                    "kotlin-language-server",
                    "glsl_analyzer",
                    "typescript-language-server",
                    "gopls",
                    "html-lsp",
                    "css-lsp",
                    "json-lsp",
                    "yaml-language-server",
                    "bash-language-server",
                    "dockerfile-language-server",
                    "taplo",
                },
                auto_install = true,
                run_on_start = true,
                start_delay = 2000, 
            })
        end,
    },

    -------------cmp---------------
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip", -- snippets
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-path", -- PATH

    "numToStr/Comment.nvim", -- gcc&gc
    "windwp/nvim-autopairs", -- auto ()[]{}""''

    "akinsho/bufferline.nvim", -- buffer <top>
    "lewis6991/gitsigns.nvim", -- git

    {
        'nvim-telescope/telescope.nvim', -- Flies Find
        dependencies = { {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        } }
    },
    {
        'VonHeikemen/fine-cmdline.nvim',
        dependencies = { {'MunifTanjim/nui.nvim'} }
    },  --cmd line
}
local opts = {}

require("lazy").setup(plugins, opts)
