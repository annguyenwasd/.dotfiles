local o = vim.opt
local wo = vim.wo
local bo = vim.bo

vim.g.vimsyn_embed = "lPr"

o.splitbelow = true
o.splitright = true
o.wildmenu = true
o.termguicolors = true
o.hidden = true
o.ignorecase = true
o.incsearch = true
o.hlsearch = true
o.expandtab = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.exrc = true
o.secure = true
o.clipboard = "unnamed"
o.updatetime = 50
o.inccommand = "nosplit"
o.mouse = "a"
o.scrolloff = 8
o.completeopt = { "menuone", "noinsert", "noselect" }
o.shortmess:append({ c = true })
o.smartindent = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
o.undofile = true
o.undodir = vim.fn.expand("$HOME/.vim/undo")
o.cmdheight = 2
o.listchars = "eol:¬,tab:▹ ,trail:+,space:·"

wo.signcolumn = "yes"

bo.syntax = "enable"

vim.cmd([[
augroup OpenHelpOnRightMostWindow
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END
]])

vim.cmd([[
augroup SetFileType
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd BufNewFile,BufRead *.zsh setlocal filetype=zsh
  autocmd FileType zsh set foldmethod=marker
  autocmd BufNewFile,BufRead *.conf setlocal filetype=conf
  autocmd FileType conf set foldmethod=marker
augroup END
]])

vim.cmd([[
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
]])
