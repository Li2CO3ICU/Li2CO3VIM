--vim.g.mapleader = " "
local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", " d", "<C-w>v") -- 水平新增窗口 
keymap.set("n", " D", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", " nh", ":nohl<CR>")

-- nvim-tree
keymap.set("n", " e", ":NvimTreeToggle<CR>")

-- telescope keymap --
keymap.set('n', ' ff', ":Telescope find_files<CR>")
keymap.set('n', ' fg', ":Telescope live_grep<CR>")
keymap.set('n', ' fb', ":Telescope buffers<CR>")
keymap.set('n', ' fh', ":Telescope help_tags<CR>")

-- find_files --
keymap.set('n', ':', '<cmd>FineCmdline<CR>')
