return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- 将原来的代码包在 config 函数内部，确保插件下载并加载后才执行
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 
        "vim", "fortran", "vimdoc", "bash", "c", "cpp", 
        "javascript", "json", "lua", "python", "typescript", 
        "tsx", "css", "rust", "markdown", "markdown_inline" 
      },
      highlight = { enable = true },
      indent = { enable = true },
      
      -- 注意：nvim-ts-rainbow 插件通常需要额外安装
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      }
    }
  end
}


