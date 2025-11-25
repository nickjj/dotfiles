return {
  {
    name = "theme-hot-reload",
    dir = vim.fn.stdpath("config"),
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyReload",
        callback = function()
          package.loaded["plugins.theme"] = nil

          vim.schedule(function()
            local ok, theme_spec = pcall(require, "plugins.theme")
            if not ok then
              return
            end

            local theme_plugin_name = nil
            for _, spec in ipairs(theme_spec) do
              if spec[1] and spec[1] ~= "LazyVim/LazyVim" then
                theme_plugin_name = spec.name or spec[1]
                break
              end
            end

            vim.cmd("highlight clear")
            if vim.fn.exists("syntax_on") then
              vim.cmd("syntax reset")
            end

            vim.o.background = "dark"

            if theme_plugin_name then
              local plugin =
                require("lazy.core.config").plugins[theme_plugin_name]
              if plugin then
                local plugin_dir = plugin.dir .. "/lua"
                require("lazy.core.util").walkmods(
                  plugin_dir,
                  function(modname)
                    package.loaded[modname] = nil
                    package.preload[modname] = nil
                  end
                )
              end
            end

            for _, spec in ipairs(theme_spec) do
              if
                spec[1] == "LazyVim/LazyVim"
                and spec.opts
                and spec.opts.colorscheme
              then
                local colorscheme = spec.opts.colorscheme

                require("lazy.core.loader").colorscheme(colorscheme)

                vim.defer_fn(function()
                  pcall(vim.cmd.colorscheme, colorscheme)
                  vim.cmd("redraw!")
                end, 5)

                break
              end
            end
          end)
        end,
      })
    end,
  },
}
