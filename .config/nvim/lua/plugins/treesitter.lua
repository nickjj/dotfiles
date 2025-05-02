return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "bezhermoso/tree-sitter-ghostty",
    },
    opts = function(_, opts)
      -- Add custom treesitters not present by default in LazyVim.
      vim.list_extend(opts.ensure_installed, {
        "csv",
        "dockerfile",
        "elixir",
        "embedded_template",
        "ghostty",
        "go",
        "heex",
        "helm",
        "htmldjango",
        "kdl",
        "liquid",
        "nginx",
        "ron",
        "ruby",
        "terraform",
        "toml",
      })

      -- Identation was often misgaligned, especially with list items. This
      -- lets Neovim handle indentation directly. This is a bug with Treesitter
      -- and should be fixed in 1.0.
      opts.indent.disable = { "yaml" }
    end,
  },
}
