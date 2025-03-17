return {
  {
    "ellisonleao/gruvbox.nvim",
    init = function()
      vim.api.nvim_set_hl(0, "SnacksPicker", { link = "GruvboxBg0" })
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "GruvboxBlue" })
      vim.api.nvim_set_hl(
        0,
        "SnacksPickerPathIgnored",
        { link = "GruvboxBg3" }
      )
      vim.api.nvim_set_hl(0, "SnacksPicker", { link = "GruvboxBg0" })
      vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "GruvboxBlue" })
      vim.api.nvim_set_hl(0, "SnacksPickerDir", { link = "GruvboxGray" })
      vim.api.nvim_set_hl(
        0,
        "SnacksPickerPathHidden",
        { link = "GruvboxGray" }
      )
      vim.api.nvim_set_hl(
        0,
        "SnacksPickerPathIgnored",
        { link = "GruvboxBg3" }
      )
      vim.api.nvim_set_hl(
        0,
        "SnacksPickerGitStatusUntracked",
        { link = "GruvboxGray" }
      )
    end,
    opts = {
      contrast = "medium",
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
      on_highlights = function(hl, c)
        hl.ColorColumn = { bg = c.bg_highlight }
        hl.SpellBad = { fg = c.red, undercurl = true }
        hl.SpellCap = { fg = c.red, undercurl = true }
        hl.SpellLocal = { fg = c.red, undercurl = true }
        hl.SpellRare = { fg = c.red, undercurl = true }
      end,
    },
  },

  -- Configure LazyVim to load the theme.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
