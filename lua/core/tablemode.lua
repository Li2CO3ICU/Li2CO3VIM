-- 1. 定义画笔样式 (保持不变)
local brushes = {
    light   = { '┌', '┬', '┐', '├', '┼', '┤', '└', '┴', '┘', '─', '│' },
    heavy   = { '┏', '┳', '┓', '┣', '╋', '┫', '┗', '┻', '┛', '━', '┃' },
    double  = { '╔', '╦', '╗', '╠', '╬', '╣', '╚', '╩', '╝', '═', '║' },
    dash2   = { '┌', '┬', '┐', '├', '┼', '┤', '└', '┴', '┘', '╌', '╎' },
    dash3   = { '┌', '┬', '┐', '├', '┼', '┤', '└', '┴', '┘', '┄', '┆' },
    dash4   = { '┌', '┬', '┐', '├', '┼', '┤', '└', '┴', '┘', '┈', '┊' },
    rounded = { '╭', '┬', '╮', '├', '┼', '┤', '╰', '┴', '╯', '─', '│' },
    arrow   = { '┌', '┬', '┐', '├', '┼', '┤', '└', '┴', '┘', '→', '↓' },
}
vim.g.current_brush_mode = "light"

-- 2. 右上角浮动弹窗逻辑
local function show_mode_popup()
    local icons = {
        light = "─", heavy = "━", double = "═", 
        dash2 = "╌", dash3 = "┄", dash4 = "┈", 
        rounded = "╭", arrow = "→"
    }
    local mode = vim.g.current_brush_mode
    local icon = icons[mode] or "─"
    local text = " 🖌️  DRAW: " .. mode:upper() .. " " .. icon .. " "

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

    -- 计算右上角位置
    local width = #text + 1
    local height = 1
    local opts = {
        relative = "editor",
        width = width,
        height = height,
        -- 定位到右上角：总宽度 - 弹窗宽度 - 偏移量
        col = vim.o.columns - width - 2,
        row = 1, -- 距离顶部 1 行
        style = "minimal",
        border = "rounded",
        focusable = false,
        noautocmd = true,
    }

    local win = vim.api.nvim_open_win(buf, false, opts)
    
    -- 设置一个优雅的高亮 (此处使用 Comment 颜色，不晃眼)
    vim.api.nvim_win_set_option(win, 'winhl', 'Normal:PmenuSel')

    -- 800毫秒后自动关闭
    vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end, 800)
end

-- 3. 切换函数
local function switch_brush(mode)
    local target = mode
    if mode == "dash" then
        if vim.g.current_brush_mode == "dash2" then target = "dash3"
        elseif vim.g.current_brush_mode == "dash3" then target = "dash4"
        else target = "dash2" end
    end
    vim.g.current_brush_mode = target
    show_mode_popup()
end

-- 4. 绘图核心与快捷键
local function draw_sign(idx)
    local char = brushes[vim.g.current_brush_mode][idx]
    vim.api.nvim_put({char}, 'c', true, true)
end

-- 映射 Alt + 1-6 切换模式
local modes = { "light", "heavy", "double", "dash", "rounded", "arrow" }
for i, m in ipairs(modes) do
    vim.keymap.set({'n', 'i'}, '<A-' .. i .. '>', function() switch_brush(m) end)
end

-- 映射 Alt + 九宫格绘图
local keys = {
    ['<A-q>'] = 1, ['<A-w>'] = 2, ['<A-e>'] = 3,
    ['<A-a>'] = 4, ['<A-s>'] = 5, ['<A-d>'] = 6,
    ['<A-z>'] = 7, ['<A-x>'] = 8, ['<A-c>'] = 9,
    ['<A-h>'] = 10, ['<A-v>'] = 11
}
-- 【原地橡皮擦】右移一位再退格加空格
vim.keymap.set({'i', 'n'}, '<A-r>', function()
    -- <Right> 往右走一步，<BS> 删掉刚走过的那个，空格补位
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right><BS> ", true, false, true), 'n', false)
end, { silent = true, nowait = true })

for key, idx in pairs(keys) do
    vim.keymap.set({'n', 'i'}, key, function() draw_sign(idx) end, { silent = true, nowait = true })
end
