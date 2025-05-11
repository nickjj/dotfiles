return {
  -- Temporarily lock mason related plugins to 1.X until LazyVim supports 2.X.
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
