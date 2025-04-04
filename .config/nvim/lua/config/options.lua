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

-- Set .aliases or any variant as "bash".
vim.filetype.add({ pattern = { ["%.*aliases.*"] = "bash" } })

-- Set .env or any variant as "dotenv" except we want .env.example to be
-- treated differently so it's easier to know we are editing an example file.
-- This has less syntax highlighting and comes up with a different explorer
-- icon so it's easier to know it's not the "real" env file.
vim.filetype.add({
  pattern = {
    ["%.env.*"] = "dotenv",
    ["%.env.example"] = { "conf", { priority = 1 } },
  },
})

-- Ensure all .env files and variants are syntax highlighted as shell scripts.
-- This goes along with the filetype addition above. We do this to avoid using
-- bash or sh so the BashLSP linter and formatter doesn't affect env files
-- since that can create a lot of unwanted false positives and side effects.
vim.treesitter.language.register("bash", "dotenv")

-- Set .gitconfig.local or any variant as "git_config".
vim.filetype.add({ pattern = { ["%.gitconfig.*"] = "git_config" } })

-- Set requirements-lock.txt or any variant as "requirements".
vim.filetype.add({ pattern = { ["requirements.*.txt"] = "requirements" } })
