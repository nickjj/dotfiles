-- Options are automatically loaded before lazy.nvim startup.
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- I prefer seeing all characters by default.
vim.opt.conceallevel = 0

-- Show a vertical line at this character.
vim.opt.colorcolumn = "80"

-- Each buffer gets its own status line instead of sharing one.
vim.opt.laststatus = 2

-- These are all invisible by default but we can toggle them with a keymap.
vim.opt.listchars = {
  eol = "$",
  tab = ">-",
  trail = "-",
  lead = "-",
  extends = "~",
  precedes = "~",
  conceal = "+",
  nbsp = "&",
}
vim.opt.list = false

-- Don't auto-scroll N number of lines from the top of the buffer.
vim.opt.scrolloff = 0

-- Allow left and right arrow keys to move to the previous and next line.
vim.opt.whichwrap = "b,s,<,>"

-- Wrap lines so it's easier to see anything that's cut off.
vim.opt.wrap = true
