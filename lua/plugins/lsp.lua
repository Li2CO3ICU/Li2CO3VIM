-- mason 安装和 UI 配置
require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
      },
  },
})

-- mason-lspconfig 确保安装的 LSP
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",                -- Lua
    "rust_analyzer",         -- Rust
    "fortls",                -- Fortran
    "pyright",               -- Python
    "clangd",                -- C / C++
    "jdtls",                 -- Java
    "kotlin_language_server" -- Kotlin
  },
})

-- nvim-cmp 自动完成能力
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua LSP 配置
require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}

-- Rust LSP 配置
require("lspconfig").rust_analyzer.setup {
  capabilities = capabilities,
}

-- Fortran LSP 配置
require("lspconfig").fortls.setup {
  capabilities = capabilities,
}

-- Python LSP 配置
require("lspconfig").pyright.setup {
  capabilities = capabilities,
}

-- C / C++ LSP 配置
require("lspconfig").clangd.setup {
  capabilities = capabilities,
}

-- Java LSP 配置
require("lspconfig").jdtls.setup {
  capabilities = capabilities,
}

-- Kotlin LSP 配置
require("lspconfig").kotlin_language_server.setup {
  capabilities = capabilities,
}

-- 全局诊断配置
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 可选：为诊断设置左侧符号
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

