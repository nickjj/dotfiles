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
          -- I created a feature request for this at:
          -- https://github.com/folke/snacks.nvim/issues/2804
          --
          -- This git_diff config can be removed if a PR addresses the above.
          git_diff = {
            toggles = {
              staged = "s",
            },
            actions = {
              toggle_staged = function(picker)
                picker.opts.staged = not picker.opts.staged
                picker:find()
              end,
            },
            win = {
              input = {
                keys = {
                  ["<A-s>"] = { "toggle_staged", mode = { "n", "i" } },
                },
              },
            },
          },
        },
        previewers = {
          diff = {
            style = "terminal",
            cmd = { "delta" },
          },
        },
        win = {
          input = {
            keys = {
              ["<PageUp>"] = { "list_scroll_up", mode = { "n", "i" } },
              ["<PageDown>"] = { "list_scroll_down", mode = { "n", "i" } },
              ["<S-Up>"] = { "preview_scroll_up", mode = { "n", "i" } },
              ["<S-Down>"] = { "preview_scroll_down", mode = { "n", "i" } },
            },
          },
        },
      },
      styles = {
        input = {
          relative = "editor",
          -- Normally this loads a bit lower in the buffer, it often blocked
          -- important text (blog post titles) in files I frequently edit.
          row = 0,
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
