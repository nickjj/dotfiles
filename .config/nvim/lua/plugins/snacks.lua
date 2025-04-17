return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.g.snacks_animate = false
    end,
    opts = {
      dashboard = { enabled = false },
      picker = {
        hidden = true,
        sources = {
          -- These define their own options, we must override their defaults.
          files = { hidden = true },
          buffers = { hidden = true },
          -- Explorer and the rest of the sources don't define their own opts
          -- so it will use the picker options defined above and we can choose
          -- to override them if desired.
          explorer = {
            ignored = true,
            -- If you prefer a right aligned explorer, uncomment this:
            -- layout = {
            --   layout = {
            --     position = "right",
            --   },
            -- },
          },
        },
      },
      terminal = {
        win = {
          position = "float",
          border = "rounded",
        },
      },
    },
  },
}
