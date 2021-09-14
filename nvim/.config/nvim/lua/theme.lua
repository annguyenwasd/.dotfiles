vim.o.termguicolors = true

vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

-- styles: darker lighter default oceanic palenight deep ocean
vim.g.material_flat_ui = 1
vim.g.material_style = "oceanic"
vim.g.material_italic_comments = 1
vim.g.material_italic_keywords = 1
vim.g.material_italic_functions = 1
-- vim.g.gh_color = "soft"

vim.g.calvera_italic_keywords = 1
vim.g.calvera_italic_functions = 1
vim.g.calvera_contrast = 1

vim.g.moonlight_italic_keywords = 1
vim.g.moonlight_italic_functions = 1
vim.g.moonlight_italic_variables = 0
vim.g.moonlight_contrast = 1
vim.g.moonlight_borders = 1
vim.g.moonlight_disable_background = 0

vim.cmd([[
augroup StatusLine
  autocmd!

  au ColorScheme nord hi Folded guifg=#54627A guibg=#2E3440 gui=NONE
  au ColorScheme nord hi StatusLine guifg=#D8DEE9

  au ColorScheme OceanicNext hi StatusLine guibg=#E5E8E8
  au ColorScheme OceanicNext hi CursorLineNr guibg=NONE guifg=#ffffff

augroup END
]])

vim.cmd([[
augroup ThemeGroup
  autocmd!
  au ColorScheme * hi Visual guibg=Yellow guifg=Black
  au ColorScheme * hi SignifySignAdd guibg=NONE
  au ColorScheme * hi SignifySignChange guibg=NONE
  au ColorScheme * hi SignifySignChangeDelete guibg=NONE
  au ColorScheme * hi SignifySignDelete guibg=NONE
  au ColorScheme * hi SignifySignDeleteFirstLine guibg=NONE
  au ColorScheme * hi EndOfBuffer guibg=NONE
  au ColorScheme * hi LineNr guibg=NONE
  au ColorScheme * hi SignColumn guibg=NONE
  au ColorScheme * hi Normal guibg=NONE " transparent
  " au ColorScheme * hi Normal guibg=#0A0E14
augroup END
]])

vim.cmd("colorscheme gruvbox8")
