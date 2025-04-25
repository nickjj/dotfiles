return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "medium",
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      overrides = {
        SnacksPicker = { link = "GruvboxBg0" },
        SnacksPickerDir = { link = "GruvboxGray" },
        SnacksPickerBorder = { link = "GruvboxBlue" },
        SnacksPickerPathHidden = { link = "GruvboxGray" },
        SnacksPickerPathIgnored = { link = "GruvboxBg3" },
        SnacksPickerGitStatusUntracked = { link = "GruvboxGray" },
        NormalFloat = { link = "GruvboxBlue" },
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
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
