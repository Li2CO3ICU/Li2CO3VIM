return {
  -- 声明插件依赖
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- 1. Mason 初始化
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- 2. Mason-LSPConfig 初始化
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", "rust_analyzer", "fortls", "pyright", 
        "clangd", "jdtls", "kotlin_language_server"
      },
    })

    -- 3. LSP 能力配置 (用于 nvim-cmp)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require("lspconfig")

    -- 4. 循环配置所有 LSP 服务（更简洁的写法）
    local servers = { 
      "lua_ls", "rust_analyzer", "fortls", "pyright", 
      "clangd", "jdtls", "kotlin_language_server" 
    }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
      })
    end

    -- 5. 全局诊断配置
    vim.diagnostic.config({
      virtual_text = { prefix = "●" },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- 设置诊断符号
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end
}

