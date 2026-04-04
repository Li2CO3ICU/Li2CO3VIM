-- ==========================================
-- 简单粗暴：强制扒掉所有背景底色 (动态跟随 Matugen 版)
-- ==========================================

-- 彻底干掉悬浮窗底层背景
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "MsgArea", { bg = "NONE" })

-- 彻底干掉 Telescope 的所有面板背景
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE" })

-- 🎯 修复 1：标题和符号只保留透明和加粗，删掉写死的 fg (前景色)
-- 这样它们就会自动继承 Matugen 生成的整体界面颜色（比如你截图里的暖橘色）
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "NONE", bold = true })

-- 🎯 修复 2：让选中行动态跟随 Matugen 主题
-- 'Visual' 是 Matugen 专门优化过的选中区域高亮，对比度极佳且会随壁纸变化
vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "Visual" })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { link = "Visual" })
return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
}
