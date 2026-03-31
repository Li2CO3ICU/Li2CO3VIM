-- lua/plugins/snacks.lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end
-- 🌈 Dashboard 渐变颜色
local colors = {
  "#5BCEFA",
  "#F5A9B8",
  "#FFFFFF",
  "#F5A9B8",
  "#5BCEFA",
  "#5BCEFA",
}
vim.api.nvim_set_hl(0, "SpeedFast",  { fg = "#a6e3a1", bold = true }) -- 绿
vim.api.nvim_set_hl(0, "SpeedOk",    { fg = "#89b4fa", bold = true }) -- 蓝
vim.api.nvim_set_hl(0, "SpeedSlow",  { fg = "#f9e2af", bold = true }) -- 黄
vim.api.nvim_set_hl(0, "SpeedBad",   { fg = "#f38ba8", bold = true }) -- 红
for i, c in ipairs(colors) do
  vim.api.nvim_set_hl(0, "T" .. i, { fg = c, bold = true })
end
-- 🐾 startup 区块
local function startup()
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
  --local ms = string.format("%.2f", stats.startuptime)
local time = stats.startuptime
local ms = string.format("%.2f", time)

local hl, icon
if time < 30 then
  hl = "SpeedFast"
  icon = "🟢 "
elseif time < 80 then
  hl = "SpeedOk"
  icon = "🔵 "
elseif time < 150 then
  hl = "SpeedSlow"
  icon = "🟡 "
else
  hl = "SpeedBad"
  icon = "🔴 "
end
  return {
    align = "center",
    text = {
      { "🏳️‍⚧️ Li2CO3VIM 已加载 ", hl = "footer" },
      { stats.loaded .. "/" .. stats.count, hl = "special" },
      { " 插件，用时 ", hl = "footer" },
      { ms .. " ms " .. icon, hl = hl },
    },
  }
end

snacks.setup({
  dashboard = {
    enabled = true,

    width = 60,
    pane_gap = 4,

    sections = {
function()
  return {
    align = "center",
    text = {
      { "██╗     ██╗██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗\n", hl = "T1" },
      { "██║     ██║╚════██╗██╔════╝██╔═══██╗╚════██╗██║   ██║██║████╗ ████║\n", hl = "T2" },
      { "██║     ██║ █████╔╝██║     ██║   ██║ █████╔╝██║   ██║██║██╔████╔██║\n", hl = "T3" },
      { "██║     ██║██╔═══╝ ██║     ██║   ██║ ╚═══██╗╚██╗ ██╔╝██║██║╚██╔╝██║\n", hl = "T4" },
      { "███████╗██║███████╗╚██████╗╚██████╔╝██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║\n", hl = "T5" },
      { "╚══════╝╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝\n", hl = "T6" },
    },
  }
end,
      --{ section = "header", padding = 1 },
      { section = "keys", gap = 1, padding = 1 },
      startup, -- ⭐ 把你的 startup 接进来（关键）
    },

    preset = {
      pick = nil, -- 防止默认覆盖

      -- 🧠 keys（你给的）
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
        { icon = "󰒲 ", key = "L", desc = "插件管理", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        { icon = " ", key = "q", desc = "退    出", action = ":qa" },
      },

      -- 🧬 header（你给的）
      --header = [[
--██╗     ██╗██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
--██║     ██║╚════██╗██╔════╝██╔═══██╗╚════██╗██║   ██║██║████╗ ████║
--██║     ██║ █████╔╝██║     ██║   ██║ █████╔╝██║   ██║██║██╔████╔██║
--██║     ██║██╔═══╝ ██║     ██║   ██║ ╚═══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
--███████╗██║███████╗╚██████╗╚██████╔╝██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
--╚══════╝╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--]],
    },
  },
})

-- 🐾 自动打开 dashboard
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    require("snacks.dashboard").open()
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    require("snacks.dashboard").update()
  end,
})
