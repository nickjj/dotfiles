local luasnip = require("luasnip")

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
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      local cmp = require("cmp")

      -- This is greyed out virtual text for the first match, I found it a
      -- little confusing to determine what's real text and what's not even
      -- though the colors are much different.
      opts.experimental = {
        ghost_text = false,
      }

      -- Disable inserting the first item unless you select it. You only need to
      -- change auto_select to true if you want to auto select the first item.
      local auto_select = false
      opts.preselect = auto_select and cmp.PreselectMode.Item
        or cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noinsert"
          .. (auto_select and "" or ",noselect"),
      }

      -- Show completions from these sources in order.
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
      })

      -- Cycle through and pick selections with Tab and Shift+Tab.
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- To get VSCode autocompletion behavior, add ({ select = true }).
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-e>"] = cmp.mapping.abort(),
      })
    end,
  },
}
