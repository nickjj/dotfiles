return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add custom treesitters not present by default in LazyVim.
      vim.list_extend(opts.ensure_installed, {
        "csv",
        "dockerfile",
        "elixir",
        "embedded_template",
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
    end,
  },
}
