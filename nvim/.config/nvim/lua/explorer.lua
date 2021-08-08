local tree_cb = require("nvim-tree.config").nvim_tree_callback
local utils = require("utils")
local map = utils.map

vim.g.nvim_tree_bindings = {
	{ key = { "l" }, cb = tree_cb("edit") },
	{ key = { "h" }, cb = tree_cb("close_node") },
}

local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

require("lir").setup({
	show_hidden_files = true,
	devicons_enable = true,
	mappings = {
		["l"] = actions.edit,
		["<C-x>"] = actions.split,
		["<C-v>"] = actions.vsplit,
		["<C-t>"] = actions.tabedit,

		["h"] = actions.up,
		["q"] = actions.quit,

		["N"] = actions.mkdir,
		["<leader>n"] = actions.newfile,
		["r"] = actions.rename,
		["@"] = actions.cd,
		["gy"] = actions.yank_path,
		["H"] = actions.toggle_show_hidden,
		["d"] = actions.delete,

		["J"] = function()
			mark_actions.toggle_mark()
			vim.cmd("normal! j")
		end,
		["c"] = clipboard_actions.copy,
		["x"] = clipboard_actions.cut,
		["p"] = clipboard_actions.paste,
	},
	float = {
		winblend = 0,

		-- -- You can define a function that returns a table to be passed as the third
		-- -- argument of nvim_open_win().
		-- win_opts = function()
		--   local width = math.floor(vim.o.columns * 0.8)
		--   local height = math.floor(vim.o.lines * 0.8)
		--   return {
		--     border = require("lir.float.helper").make_border_opts({
		--       "+", "─", "+", "│", "+", "─", "+", "│",
		--     }, "Normal"),
		--     width = width,
		--     height = height,
		--     row = 1,
		--     col = math.floor((vim.o.columns - width) / 2),
		--   }
		-- end,
	},
	hide_cursor = true,
})

-- use visual mode
function _G.LirSettings()
	vim.api.nvim_buf_set_keymap(
		0,
		"x",
		"J",
		':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
		{ noremap = true, silent = true }
	)

	-- echo cwd
	vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
end

vim.cmd([[
augroup lir-settings
autocmd!
autocmd Filetype lir :lua LirSettings()
augroup END
]])

vim.g.nvim_tree_width = 40 --30 by default, can be width_in_columns or 'width_in_percent%'
vim.g.nvim_tree_quit_on_open = 1 --0 by default, closes the tree when you open a file
vim.g.nvim_tree_follow = 1 --0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markers = 0 --0 by default, this option shows indent markers when folders are open

map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
map("n", "<leader>j", ":lua require('lir.float').toggle()<cr>")
