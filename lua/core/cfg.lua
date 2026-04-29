--vim.opt.mouse = ""

local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 2        -- 制表符显示为4个空格宽
opt.shiftwidth = 2     -- 用于自动缩进的宽度
opt.expandtab = false-- 使用制表符进行缩进
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = false

-- 鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"



-- lua/core/cfg.lua

-- ==========================================
-- 🎨 主题与配色设置
-- ==========================================

-- 尝试安全加载 Matugen 动态生成的配色
local ok, _ = pcall(require, "core.generated")

if not ok then
    -- 如果因为某些原因找不到 generated.lua（比如换了新电脑还没跑脚本）
    -- 弹出一个小提示，并且应用一个备用主题
    vim.notify("喵呜... 未找到 Matugen 配色文件，启用了备用主题 🐾", vim.log.levels.WARN, { title = "Theme" })
    
    -- 你可以把你之前装的 catppuccin 作为备用主题
    -- 前提是你的 lazy.nvim 插件列表里还留着 "catppuccin/nvim"
    local fallback_ok, _ = pcall(vim.cmd, "colorscheme catppuccin")
    if not fallback_ok then
        -- 最差的情况：连备用主题都没装，就用 Neovim 自带的
        vim.cmd("colorscheme habamax")
    end
end

-- ==========================================
-- 🐾 其他核心设置 (如果你有的话可以接着写在下面)
-- ==========================================
-- vim.opt.number = true 
-- vim.opt.relativenumber = true


vim.opt.shell = "/usr/bin/fish"



-- 中文标点自动转英文标点 (仅在插入模式下)
local punctuation_map = {
    ["！"] = "!",
    ["（"] = "(",
    ["）"] = ")",
    ["‘"] = "'",
    ["“"] = '"',
    ["，"] = ",",
    ["。"] = ".",
    ["？"] = "?",
    ["【"] = "[",
    ["】"] = "]",
    ["·"] = "`",
    ["："] = ":",
    ["；"] = ";",
}

for zh, en in pairs(punctuation_map) do
    vim.keymap.set('i', zh, en, { noremap = true, silent = true })
end
