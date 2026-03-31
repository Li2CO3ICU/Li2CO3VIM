return {
  {
    "folke/snacks.nvim",
    priority = 1000, -- 确保最早加载，避免被覆盖
    lazy = false,

    opts = {
      dashboard = {
        sections = {
          { section = "header", padding = 1 },
          { section = "keys", gap = 1, padding = 1 },

          -- 底部统计信息
          function()
            local ok, lazy_stats = pcall(require, "lazy.stats")
            if not ok then
              return {
                align = "center",
                text = {
                  { "⚠️ lazy.nvim 未加载", hl = "Comment" },
                },
              }
            end

            local stats = lazy_stats.stats()
            local ms = string.format("%.2f", stats.startuptime)

            return {
              align = "center",
              text = {
                { "🏳️‍⚧️ Li2CO3VIM 已加载 ", hl = "Title" },
                { stats.loaded .. "/" .. stats.count, hl = "Number" },
                { " 插件，用时 ", hl = "Comment" },
                { ms .. " ms ", hl = "String" },
              },
            }
          end,
        },

        preset = {
          pick = nil, -- ⭐ 关键！防止默认 preset 覆盖

          header = [[
██╗     ██╗██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██║     ██║╚════██╗██╔════╝██╔═══██╗╚════██╗██║   ██║██║████╗ ████║
██║     ██║ █████╔╝██║     ██║   ██║ █████╔╝██║   ██║██║██╔████╔██║
██║     ██║██╔═══╝ ██║     ██║   ██║ ╚═══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
██║     ██║██╔═══╝ ██║     ██║   ██║ ╚═══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
██║     ██║██╔═══╝ ██║     ██║   ██║ ╚═══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
██║     ██║██╔═══╝ ██║     ██║   ██║ ╚═══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗██║███████╗╚██████╗╚██████╔╝██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],

          keys = {
            { icon = " ", key = "f", desc = "查找文件", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "新建文件", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "查找文本", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "最近文件", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "配置文件",
              action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
            },
            { icon = " ", key = "s", desc = "恢复会话", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "插件管理", action = ":Lazy", enabled = pcall(require, "lazy") },
            { icon = " ", key = "q", desc = "退    出", action = ":qa" },
          },
        },
      },
    },

    config = function(_, opts)
      require("snacks").setup(opts)

      -- ⭐ 确保 dashboard 打开
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("snacks.dashboard").open()
        end,
      })
    end,
  },
}
