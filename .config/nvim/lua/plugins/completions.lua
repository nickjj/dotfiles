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
      },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = true },
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
              -- Only show after inputting 3+ characters.
              if
                ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil
              then
                return 3
              end

              return 0
            end,
          },
        },
      },
    },
  },
}
