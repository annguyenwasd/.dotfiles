local utils = require("utils")
local map = utils.map

vim.g.vimspector_base_dir = vim.fn.expand("$HOME/.vim/vimspector-config")

if vim.bo.filetype == "java" then
	map("n", "<leader>dd", ":CocCommand java.debug.vimspector.start<cr>")
else
	map("n", "<leader>dd", ":<c-u>call vimspector#Launch()<cr>")
end

map("n", "<leader>ds", ":VimspectorReset<cr>")
map("n", "<leader>dS", ":<c-u>call vimspector#Stop()<cr>")
map("n", "<leader>rs", ":<c-u>call vimspector#Restart()<cr>")
map("n", "<leader>dp", ":<c-u>call vimspector#Pause()<cr>")
map("n", "<leader>db", ":<c-u>call vimspector#ToggleBreakpoint()<cr>")
map(
	"n",
	"<leader>dB",
	':<c-u>call vimspector#ToggleBreakpoint( { "condition": input( "Enter condition expression: " ), "hitCondition": input( "Enter hit count expression: " ) })<cr>'
)
map("n", "<leader>fb", ":<c-u>call vimspector#AddFunctionBreakpoint( ' < cexpr > ' )<cr>")
map("n", "<leader>cb", ":<c-u>call vimspector#ClearBreakpoints()<cr>")
map("n", "<leader>rc", ":<c-u>call vimspector#RunToCursor()<cr>")

map("n", "<leader>do", ":<c-u>call vimspector#StepOver()<cr>")
map("n", "<leader>di", ":<c-u>call vimspector#StepInto()<cr>")
map("n", "<leader>dO", ":<c-u>call vimspector#StepOut()<cr>")
map("n", "<leader>dc", ":<c-u>call vimspector#Continue()<cr>")

map("n", "<leader>dk", ":<c-u>call vimspector#UpFrame()<cr>")
map("n", "<leader>dj", ":<c-u>call vimspector#DownFrame()<cr>")

map("n", "<leader>dE", ":<Plug>VimspectorBalloonEval<space>")
map("n", "<leader>de", ":VimspectorEval<space>")
map("n", "<leader>dw", ":VimspectorWatch<space>")
