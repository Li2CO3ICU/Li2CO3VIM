-- lua/plugins/snacks.lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end  -- 如果插件没加载，不报错

snacks.setup({
    dashboard = {
        enabled = true    -- 开启 dashboard
    }
})
