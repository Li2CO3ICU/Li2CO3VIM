require("toggleterm").setup({
  open_mapping = [[<leader>t]],
  direction = "float",
  shell = "/bin/kitty",
  close_on_exit = false, -- ⭐ 防止直接消失
})
