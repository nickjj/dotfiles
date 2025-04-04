return {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        ghost_text = { enabled = false },
      },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(_)
              -- Only trigger the menu for :, this avoids triggering it when
              -- doing / (search) or other commands.
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
        keymap = {
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },

        -- This is only needed until LazyVim ships its next version since it
        -- currently sets sources = {} in v14.14.0.
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward.
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands.
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
      },
      sources = {
        providers = {
          cmdline = {
            min_keyword_length = function(ctx)
              -- Only show after inputting 4+ characters.
              if
                ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil
              then
                return 4
              end

              return 0
            end,
          },
        },
      },
    },
  },
}
