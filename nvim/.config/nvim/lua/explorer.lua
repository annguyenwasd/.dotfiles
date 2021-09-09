local tree_cb = require("nvim-tree.config").nvim_tree_callback
local utils = require("utils")
local map = utils.map

vim.g.nvim_tree_bindings = {
	{ key = { "l" }, cb = tree_cb("edit") },
	{ key = { "h" }, cb = tree_cb("close_node") },
}

vim.g.nvim_tree_width = 80 --30 by default, can be width_in_columns or 'width_in_percent%'
vim.g.nvim_tree_quit_on_open = 1 --0 by default, closes the tree when you open a file
vim.g.nvim_tree_follow = 1 --0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markers = 0 --0 by default, this option shows indent markers when folders are open

map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
