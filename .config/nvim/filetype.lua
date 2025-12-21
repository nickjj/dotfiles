-- Set .aliases or any variant as "bash".
vim.filetype.add({ pattern = { ["%.*aliases.*"] = "bash" } })

-- Set .zprofile or any variant as "bash".
vim.filetype.add({ pattern = { ["%.*zprofile.*"] = "bash" } })

-- Set .env or any variant as "dotenv" except we want .env.example files to be
-- treated differently so it's easier to know we are editing an example file.
-- This has less syntax highlighting and comes up with a different explorer
-- icon so it's easier to know it's not the "real" env file.
vim.filetype.add({
  pattern = {
    ["%.env.*"] = "dotenv",
    ["%.env.*.example"] = { "conf", { priority = 1 } },
  },
})

-- Ensure all .env files and variants are syntax highlighted as shell scripts.
-- This goes along with the filetype addition above. We do this to avoid using
-- bash or sh so the BashLSP linter and formatter doesn't affect env files
-- since that can create a lot of unwanted false positives and side effects.
vim.treesitter.language.register("bash", "dotenv")

-- Define a few file variants to be specific file types.
vim.filetype.add({ pattern = { [".*/.config/ghostty/.*"] = "ini" } })
vim.filetype.add({ pattern = { [".*/.config/mako/.*"] = "ini" } })
vim.filetype.add({ pattern = { [".*/.config/niri/.*kdl.local"] = "kdl" } })
vim.filetype.add({ pattern = { [".*/git/config.*"] = "git_config" } })
vim.filetype.add({ pattern = { ["requirements.*.txt"] = "requirements" } })
