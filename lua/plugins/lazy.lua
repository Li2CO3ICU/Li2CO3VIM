local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- 界面与美化
	"folke/snacks.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "catgoose/nvim-colorizer.lua", event = "BufReadPre", opts = {} },
	"folke/tokyonight.nvim",
	"catppuccin/nvim",
	"xiyaowong/transparent.nvim",
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"christoomey/vim-tmux-navigator",
	{ "RRethy/base16-nvim", lazy = false, priority = 1000 },
	"sphamba/smear-cursor.nvim",

	-- Treesitter 语法高亮
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local status, configs = pcall(require, "nvim-treesitter.configs")
			if not status then
				return
			end
			configs.setup({
				ensure_installed = { "lua", "vim", "rust", "cpp", "python", "glsl", "bash", "markdown" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- Markdown 增强
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		-- 确保所有依赖都在这里
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- 1. 强制按顺序获取模块
			local mason = require("mason")
			local mlsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			-- 2. 【核心修复】必须先初始化 mason，再初始化 mlsp
			-- 即使你在别处写过 mason.setup，这里再调一次是最保险的
			mason.setup({
				ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
			})

			-- 3. 现在初始化 mlsp 就不会报错了
			mlsp.setup({
				ensure_installed = { "rust_analyzer", "lua_ls", "pyright", "taplo" },
			})

			-- 4. 配置服务器 (手动遍历，避开 setup_handlers 可能的 nil 坑)
			local servers = { "rust_analyzer", "lua_ls", "pyright", "taplo" }
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
    	-- 如果 LSP 支持 Inlay Hints，就启用它
    		if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
        	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    		end
			end


			for _, server in ipairs(servers) do
				local opts = {
					capabilities = capabilities, 
					on_attach = on_attach,
				}

				-- Rust 特殊设置
				if server == "rust_analyzer" then
					opts.settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								enable = true, 
								command = "clippy", 
							},
							procMacro = {
								enable = true 
							},
							cargo = {
								allFeatures = true
							},
							files = {
                excludeDirs = { ".git", "target", "node_modules" },
            	},
							inlayHints = {
        				bindingModeHints = { enable = true },
        				chainingHints = { enable = true },
        				closingBraceHints = { enable = true, minLines = 25 },
        				parameterHints = { enable = true },
        				typeHints = { enable = true },
    					},
						},
					}
				end

				-- 适配 0.11+ 或旧版
				if vim.lsp.config then
					vim.lsp.config(server, opts)
					vim.lsp.enable(server)
				else
					lspconfig[server].setup(opts)
				end
			end
			
			vim.api.nvim_create_autocmd("LspAttach", {
    		callback = function(args)
        	local client = vim.lsp.get_client_by_id(args.data.client_id)
        	if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        	end
    		end,
			})
		end,
	},

	-- 2. 桥梁插件：把 setup_handlers 移到这里！
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- 1. 严格按顺序手动加载模块
			local mason = require("mason")
			local mlsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local cmp_lsp = require("cmp_nvim_lsp")

			-- 2. 强制初始化底座 (解决 "mason.nvim has not been set up" 报错)
			mason.setup({
				ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
			})

			-- 3. 初始化桥梁 (这一步只负责确保安装，不负责配置)
			-- 如果这里还报 "not a valid entry"，我们就把 ensure_installed 留空，
			-- 然后你去命令行手动执行 :MasonInstall rust-analyzer lua-language-server
			mlsp.setup({
				ensure_installed = { "rust_analyzer", "lua_ls", "pyright", "taplo" },
			})

			-- 4. 【核心跳坑】完全不使用 setup_handlers！
			-- 我们手动定义需要开启的服务列表
			local servers = { "rust_analyzer", "lua_ls", "pyright", "taplo" }
			local capabilities = cmp_lsp.default_capabilities()

			-- 循环手动配置每一个服务器
			for _, server in ipairs(servers) do
				local opts = { capabilities = capabilities }

				-- 针对 Rust 的特殊增强
				if server == "rust_analyzer" then
					opts.settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
							procMacro = { enable = true },
							cargo = { allFeatures = true },
						},
					}
				end

				-- 适配 Neovim 0.11+ 的新接口
				if vim.lsp.config then
					vim.lsp.config(server, opts)
					vim.lsp.enable(server)
				else
					-- 0.10 及以下版本的标准写法
					local ok, s = pcall(function() return lspconfig[server] end)
					if ok and s then
						s.setup(opts)
					end
				end
			end
		end,
	},

	-- 3. LSP 核心 (现在它只需要负责加载，逻辑已经被上面的 bridge 处理了)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
	},

	-- 补全系统
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	"hrsh7th/cmp-path",

	-- 编辑辅助
	"numToStr/Comment.nvim",
	"windwp/nvim-autopairs",
	"akinsho/bufferline.nvim",
	"lewis6991/gitsigns.nvim",

	-- 功能插件
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	},
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
}

require("lazy").setup(plugins, {})
