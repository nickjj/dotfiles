-- Options are automatically loaded before lazy.nvim startup.
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Certain but not all LSPs will set the root directory based on which buffer
-- is active. This affects picking files. I found this to be disruptive, for
-- example editing a Lua file in my dotfiles prevented me from fuzzy finding
-- files of the nvim/ directory. Remove this to bring things back to LazyVim's
-- default behavior.
vim.g.root_spec = { "cwd" }

-- The ~/.local/state/nvim/lsp.log can get pretty noisy. Mine was ~28MB after 2
-- weeks with the default setting. My thought process here is it can remain OFF
-- by default but if you're looking to troubleshoot something you can
-- temporarily set this to WARN or ERROR.
vim.lsp.set_log_level("OFF")

local opt = vim.opt

-- I prefer seeing all characters by default.
opt.conceallevel = 0

-- Show a vertical line at this character.
opt.colorcolumn = "80"

-- Each buffer gets its own status line instead of sharing one.
opt.laststatus = 2

-- These are all invisible by default but we can toggle them with a keymap.
opt.listchars = {
  eol = "$",
  tab = ">-",
  trail = "-",
  lead = "-",
  extends = "~",
  precedes = "~",
  conceal = "+",
  nbsp = "&",
}
opt.list = false

-- Don't auto-scroll N number of lines from the top of the buffer.
opt.scrolloff = 0

-- Allow left and right arrow keys to move to the previous and next line.
opt.whichwrap = "b,s,<,>"

-- Wrap lines so it's easier to see anything that's cut off.
opt.wrap = true
