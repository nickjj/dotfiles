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
        SnacksPickerBorder = { link = "GruvboxBlue" },
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
        hl.SnacksPickerPathHidden = { fg = c.comment }
        hl.SnacksPickerDir = { fg = c.comment }
        hl.SnacksPickerGitStatusIgnored = { fg = c.nontext }
        hl.SnacksPickerGitStatusUntracked = { fg = c.nontext }
        hl.ColorColumn = { bg = c.bg_highlight }
        hl.SpellBad = { fg = c.red, undercurl = true }
        hl.SpellCap = { fg = c.red, undercurl = true }
        hl.SpellLocal = { fg = c.red, undercurl = true }
        hl.SpellRare = { fg = c.red, undercurl = true }
      end,
    },
  },
}
