--vim.opt.mouse = ""

local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 4        -- 制表符显示为4个空格宽
opt.shiftwidth = 4     -- 用于自动缩进的宽度
opt.expandtab = false  -- 使用制表符进行缩进
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

-- 设置主题
--vim.cmd[[colorscheme tokyonight-moon]]
vim.cmd.colorscheme "catppuccin-mocha" --latte,frappe,macchiato,mocha

--设置pwsh
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

