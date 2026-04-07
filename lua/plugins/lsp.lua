return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()

    local lspconfig = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", "rust_analyzer", "pyright", "clangd", "ts_ls", "taplo"
      }
    })

    -- 改进：自动配置所有通过 Mason 安装的 LSP
    require("mason-lspconfig").setup_handlers({
      function(server_name) -- 默认处理函数
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- 你可以在这里为特定 LSP 写特殊配置
      -- ["rust_analyzer"] = function()
      --   lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      -- end,
    })

    -- 全局诊断配置保持不变
    vim.diagnostic.config({
      virtual_text = {
    	spacing = 4,
    	source = "if_many", -- 如果有多个来源则显示来源（比如 rust-analyzer）
    	prefix = "■",       -- 提示信息前的符号
  	},
      signs = true,
      underline = true,
      update_in_insert = true, -- 改为 true 可以在打字时实时看到报错
      severity_sort = true,
    })
  end
}
