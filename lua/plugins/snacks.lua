-- lua/plugins/snacks.lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end
-- 🌈 Dashboard 渐变颜色
local colors = {
	"#f4b8e4",
  "#ca9ee6",
  "#e78284",
  "#ea999c",
  "#ef9f76",
  "#e5c890",
  "#a6d189",
  "#81c8be",
  "#99d1db",
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
      { "██╗     ", hl = "T1" },{ "██╗", hl = "T2" },{ "██████╗ ", hl = "T3" },{ " ██████╗", hl = "T4" },{ " ██████╗ ", hl = "T5" },{ "██████╗ ", hl = "T6" },{ "██╗   ██╗", hl = "T7" },{ "██╗", hl = "T8" },{ "███╗   ███╗\n", hl = "T9" },
      { "██║     ", hl = "T1" },{ "██║", hl = "T2" },{ "╚════██╗", hl = "T3" },{ "██╔════╝", hl = "T4" },{ "██╔═══██╗", hl = "T5" },{ "╚════██╗", hl = "T6" },{ "██║   ██║", hl = "T7" },{ "██║", hl = "T8" },{ "████╗ ████║\n", hl = "T9" },
      { "██║     ", hl = "T1" },{ "██║", hl = "T2" },{ " █████╔╝", hl = "T3" },{ "██║     ", hl = "T4" },{ "██║   ██║", hl = "T5" },{ " █████╔╝", hl = "T6" },{ "██║   ██║", hl = "T7" },{ "██║", hl = "T8" },{ "██╔████╔██║\n", hl = "T9" },
      { "██║     ", hl = "T1" },{ "██║", hl = "T2" },{ "██╔═══╝ ", hl = "T3" },{ "██║     ", hl = "T4" },{ "██║   ██║", hl = "T5" },{ " ╚═══██╗", hl = "T6" },{ "╚██╗ ██╔╝", hl = "T7" },{ "██║", hl = "T8" },{ "██║╚██╔╝██║\n", hl = "T9" },
      { "███████╗", hl = "T1" },{ "██║", hl = "T2" },{ "███████╗", hl = "T3" },{ "╚██████╗", hl = "T4" },{ "╚██████╔╝", hl = "T5" },{ "██████╔╝", hl = "T6" },{ " ╚████╔╝ ", hl = "T7" },{ "██║", hl = "T8" },{ "██║ ╚═╝ ██║\n", hl = "T9" },
      { "╚══════╝", hl = "T1" },{ "╚═╝", hl = "T2" },{ "╚══════╝", hl = "T3" },{ " ╚═════╝", hl = "T4" },{ " ╚═════╝ ", hl = "T5" },{ "╚═════╝ ", hl = "T6" },{ "  ╚═══╝  ", hl = "T7" },{ "╚═╝", hl = "T8" },{ "╚═╝     ╚═╝\n", hl = "T9" },
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



-- ==========================================
-- 🐾 自定义剪贴板提示功能 (纯 Lua 代码版)
-- ==========================================

-- 1. 监听【复制】和【剪切】操作
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("ClipboardNotify", { clear = true }),
    callback = function()
        -- 附加功能：被复制/剪切的文本会闪烁一下 (高亮 150 毫秒)
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
        
        local event = vim.v.event
        local lines = #event.regcontents
        local op = event.operator -- 'y' 代表 yank(复制), 'd' 代表 delete(剪切/删除)
        
        -- 优化：过滤掉单字符的删除（比如按 x 删掉一个字母），避免弹窗太频繁干扰思路
        if op == 'd' and lines == 1 and #event.regcontents[1] <= 1 then 
            return 
        end
        
        local action = op == 'y' and "复制" or "剪切"
        vim.notify(string.format("喵！%s了 %d 行内容 🐾", action, lines), vim.log.levels.INFO, { title = "剪贴板" })
    end,
})

-- 2. 监听【粘贴】操作
local function paste_notify(key)
    return function()
        vim.notify("吧唧！粘贴成功啦 🐟", vim.log.levels.INFO, { title = "剪贴板" })
        -- 返回按键本身，expr = true 会让 Neovim 原样执行这个按键的功能
        return key
    end
end

-- 覆盖普通的粘贴按键
vim.keymap.set({ 'n', 'x' }, 'p', paste_notify('p'), { expr = true, desc = "粘贴并提示" })
vim.keymap.set({ 'n', 'x' }, 'P', paste_notify('P'), { expr = true, desc = "在前方粘贴并提示" })
