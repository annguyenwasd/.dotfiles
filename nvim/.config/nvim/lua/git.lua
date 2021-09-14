local utils = require("utils")
local map = utils.map

-- Not gonna show shit messages when run git hook via husky
vim.g.fugitive_pty = 0
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.9

vim.cmd([[
augroup Fugitive
  autocmd!
  " Auto-clean fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
]])

vim.cmd([[
function GitCommit() abort
  !git add -A
  vsplit term://git commit
endfunction
]])

map("n", "<leader><leader>f", "<cmd>diffget //2 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")
map("n", "<leader><leader>j", "<cmd>diffget //3 <cr> <cmd>w <cr> <cmd>diffupdate <cr>")

map("n", "<leader>lg", "<cmd>LazyGit<cr>")
map("n", "<leader>gl", "<cmd>0Glog<cr>")
map("n", "<leader>gs", "<cmd>G difftool --name-status<cr>")
map("n", "<localleader>gs", "<cmd>G difftool<cr>")
map("n", "<localleader>bl", "<cmd>G blame<cr>")
map("n", "<leader>gc", ":call GitCommit()<cr>")
map("n", "<leader>ga", "<cmd>G add -A<cr>")
map("n", "<leader>gw", '<cmd>G add -A <bar>G commit -n -m "WIP"<cr>')
map("n", "<leader>gp", ":AsyncRun git push origin $(git rev-parse --abbrev-ref HEAD)<cr>", { silent = false })

require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	numhl = false,
	linehl = false,
	keymaps = {
		-- Default keymap options
		noremap = true,
		buffer = true,

		["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>zo'" },
		["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>zo'" },

		["n <leader>ha"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["v <leader>ha"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <leader>hd"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["v <leader>hd"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>hD"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		["n <leader>hc"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>bl"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

		-- Text objects
		["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	},
	watch_index = {
		interval = 1000,
		follow_files = true,
	},
	current_line_blame = false,
	current_line_blame_delay = 1000,
	current_line_blame_position = "eol",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	word_diff = false,
	use_decoration_api = true,
	use_internal_diff = true, -- If luajit is present
})
