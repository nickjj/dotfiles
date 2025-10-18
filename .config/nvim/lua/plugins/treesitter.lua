return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "bezhermoso/tree-sitter-ghostty",
    },
    opts_extend = { "ensure_installed" },
    opts = {
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
        "ini",
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
