return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "bezhermoso/tree-sitter-ghostty",
    },
    opts_extend = { "ensure_installed" },
    opts = {
      -- Identation was often misgaligned, especially with list items. This
      -- lets Neovim handle indentation directly. This is a bug with Treesitter
      -- and should be fixed in 1.0.
      indent = {
        disable = { "yaml" },
      },
      -- Add custom treesitters not present by default in LazyVim.
      ensure_installed = {
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
      },
    },
  },
}
