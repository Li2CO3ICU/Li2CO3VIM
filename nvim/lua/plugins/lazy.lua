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
	"folke/tokyonight.nvim", -- tokyonight theme
	"catppuccin/nvim",	--catppucin theme
	"nvim-lualine/lualine.nvim",  -- dock status
	"nvim-tree/nvim-tree.lua",  -- as name
	"nvim-tree/nvim-web-devicons", -- tree icon
	"christoomey/vim-tmux-navigator", -- ctl-hjkl
	{
		"nvim-treesitter/nvim-treesitter", -- highlight
		run = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.install'.compilers = { "gcc" } 
		end,
	},
	{'akinsho/toggleterm.nvim', version = "*", config = true}, -- terminal<A-p>
	{"sphamba/smear-cursor.nvim"},
	{
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
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
    'nvim-telescope/telescope.nvim', tag = '0.1.8', -- Flies Find
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
