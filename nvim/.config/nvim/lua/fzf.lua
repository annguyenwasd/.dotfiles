local utils = require("utils")
local map = utils.map

map("n", "<leader>o", "<cmd>Files<cr>")
map("n", "<leader>O", "<cmd>History<cr>")
map("n", "<leader>i", "<cmd>Buffers<cr>")
map("n", "<leader>/", "<cmd>BLines<cr>")
map("n", "<leader><leader>/", "<cmd>Lines<cr>")
map("n", "<leader>rg", ":RG<space>", { silent = false })
map("n", "<leader>fh", "<cmd>Helptags<cr>")
map("n", "<leader>ch", "<cmd>History:<cr>")
map("n", "<leader>sh", "<cmd>History/<cr>")
map("n", "<leader>fc", "<cmd>Commands<cr>")
map("n", "<leader>fl", "<cmd>Lines<cr>")
map("n", "<localleader>fc", "<cmd>Colors<cr>")
map("n", "<leader>km", "<cmd>Maps<cr>")
map("n", "<leader>ff", "<cmd>Files %:h<cr>")

-- Default fzf layout
-- Popup window (center of the screen)
-- vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- Popup window (center of the current window)
-- vim.g.fzf_layout = { window = { width = 0.9, height = 0.6, relative = true } }

--  Popup window (anchored to the bottom of the current window)
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6, relative = true, yoffset = 1.0 } }

-- down / up / left / right
-- vim.g.fzf_layout = { down = "30%" }
--
-- Window using a Vim command
-- vim.g.fzf_layout = { window = "enew" }
-- vim.g.fzf_layout = { window = "-tabnew" }
-- vim.g.fzf_layout = { window = "10new" }

vim.g.fzf_buffers_jump = 1
vim.g.fzf_preview_window = { "right:60%:hidden", "?" }
