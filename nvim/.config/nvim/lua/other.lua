local utils = require("utils")
local map = utils.map

require("colorizer").setup()
require("nvim-web-devicons").setup({
	override = {
		typescriptreact = {
			icon = "",
			color = "#519aba",
			name = "Tsx",
		},
		javascriptreact = {
			icon = "",
			color = "#519aba",
			name = "Jsx",
		},
		typescript = {
			icon = "",
			color = "#519aba",
			name = "Ts",
		},
		lir_folder_icon = {
			icon = " ",
			color = "#7ebae4",
			name = "LirFolderNode",
		},
	},
	default = true,
})

require("harpoon").setup()

require("nvim-comment-frame").setup({

	-- if true, <leader>cf keymap will be disabled
	disable_default_keymap = false,

	-- adds custom keymap
	keymap = "<leader>cm",

	-- width of the comment frame
	frame_width = 70,

	-- wrap the line after 'n' characters
	line_wrap_len = 50,

	-- automatically indent the comment frame based on the line
	auto_indent = true,

	-- add comment above the current line
	add_comment_above = true,

	languages = {},
})

vim.g.gtmux_navigator_disable_when_zoomed = 1

map("n", "<leader>u", ":UndotreeShow<cr>")
map("n", "<leader>m", ":MaximizerToggle<cr>")

map("n", "ma", '<cmd>lua require("harpoon.mark").add_file()<cr>')
map("n", "'1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>')
map("n", "'2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>')
map("n", "'3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>')
map("n", "'4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>')
map("n", "'5", '<cmd>lua require("harpoon.ui").nav_file(5)<cr>')
map("n", "mq", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>')

vim.g.asyncrun_open = 40
