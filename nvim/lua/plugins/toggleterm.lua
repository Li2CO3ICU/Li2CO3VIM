require("toggleterm").setup {
	size = 20,  -- 默认终端窗口大小
	start_in_insert = true,  -- 启动时进入插入模式
	open_mapping = [[<A-p>]], -- 用于打开 PowerShell Alt+P
	shell = 'pwsh',  -- 使用 PowerShell 7 作为终端
	direction = 'float',  -- 设置终端为标签页模式
	hide_numbers = true,  -- 隐藏行号
	shade_filetypes = {},  -- 不使用背景阴影
	shading_factor = 2,  -- 背景阴影的深度
	persist_size = true,  -- 保持终端大小
	insert_mappings = true,  -- 启用插入模式的快捷键
	terminal_mappings = true,  -- 启用终端模式的快捷键
	close_on_exit = true,  -- 退出时关闭终端
	winbar = 'Terminal',  -- 启用 winbar, 设置为 "Terminal" 显示
}
