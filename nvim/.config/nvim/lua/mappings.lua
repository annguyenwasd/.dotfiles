local utils = require("utils")
local ex = vim.api.nvim_command

local map = utils.map
local t = utils.t

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "n", "nzozt", { noremap = false })
map("n", "N", "Nzozt", { noremap = false })
map("n", "*", "*zozt", { noremap = false })
map("n", "#", "#zozt", { noremap = false })

map("n", "Y", "y$")

-- Duplicate everything selected
map("v", "D", "y'>p")

-- Do search with selected text in VISUAL mode
map("v", "*", 'y<cmd>let @/ = @"<cr><cmd>set hlsearch<cr>', { noremap = false })

map("n", "<leader>cl", "<cmd>ccl<cr><cmd>lcl<cr><cmd>echo ''<cr><cmd>noh<cr>")
map("n", "<leader><leader>r", "<cmd>so ~/.config/nvim/init.vim<cr>")

map("n", "<c-w><c-e>", "<c-w>=")

-- Moving around in command mode
map("c", "<c-h>", "<left>", { silent = false })
map("c", "<c-j>", "<down>", { silent = false })
map("c", "<c-k>", "<up>", { silent = false })
map("c", "<c-l>", "<right>", { silent = false })

map("i", "<c-h>", "<left>", { silent = false })
map("i", "<c-j>", "<down>", { silent = false })
map("i", "<c-k>", "<up>", { silent = false })
map("i", "<c-l>", "<right>", { silent = false })

map("n", "<leader>e", "<cmd>b #<cr>")
map("n", "<leader><leader>e", "<cmd>e<cr>")
map("n", "<leader><leader>b", "<cmd>BufOnly<cr>")

-- Create file at same folder with vsplit/split
map("n", "<localleader>vf", ":vsp %:h/", { silent = false })
map("n", "<localleader>sf", ":sp %:h/", { silent = false })
map("n", "<localleader>ff", ":e %:h/", { silent = false })

map("n", "<leader><leader>h", 'yi" :!npm home <c-r>"<cr>')
map("n", "<leader><leader>H", "yi' :!npm home <c-r>\"<cr>")
map(
	"n",
	"<leader><leader>oj",
	'0/[DT-<cr>yi[<cmd>nohl<cr> :!open -a google chrome https://dolenglish.atlassian.net/browse/<c-r>"<cr>'
)
map("n", "<leader><leader>oe", "<cmd>!open -a textedit %<cr>")
map("n", "<leader><leader>ov", "<cmd>!open -a vimr %<cr>")
map("n", "<leader><leader>oc", "<cmd>!open -a visual studio code %<cr>")
map("n", "<leader><leader>og", "<cmd>!open -a google chrome %<cr>")

-- Windows
map("n", "<c-w>v", "<c-w>v <c-w>l", { noremap = true })
map("n", "<c-w><c-v>", "<c-w>v <c-w>l", { noremap = true })
map("n", "<c-w>s", "<c-w>s <c-w>j", { noremap = true })
map("n", "<c-w><c-s>", "<c-w>s <c-w>j", { noremap = true })
map("n", "<c-w><c-w>", "<c-w>q", { noremap = true })

map("n", "<leader>rr", '"rciw')

function _G.copyFileName()
	vim.fn.setreg("*", vim.fn.expand("%:t"))
	vim.fn.setreg("r", vim.fn.expand("%:t"))
end

function _G.copyAbsouPathPath()
	vim.fn.setreg("*", vim.fn.expand("%:p"))
	vim.fn.setreg("r", vim.fn.expand("%:p"))
end

function _G.copyFileRelativePath()
	vim.fn.setreg("*", vim.fn.expand("%"))
	vim.fn.setreg("r", vim.fn.expand("%"))
end

function _G.copyFileRelativeFolderPath()
	vim.fn.setreg("*", vim.fn.expand("%:h"))
	vim.fn.setreg("r", vim.fn.expand("%:h"))
end

function _G.openCurrentFolder()
	ex("!open %:p:h")
end

function _G.googleJavaFormat()
	ex("!google-java-format --replace % ")
end

ex("command! CopyFileName :call v:lua.copyFileName()")
ex("command! CopyAbsouPathPath :call v:lua.copyAbsouPathPath()")
ex("command! CopyFileRelativePath :call v:lua.copyFileRelativePath()")
ex("command! CopyFileRelativeFolderPath :call v:lua.copyFileRelativeFolderPath()")

ex("command! GoogleJavaFormat :call v:lua.googleJavaFormat()")
ex("command! OpenCurrentFolder :call v:lua.openCurrentFolder()")
