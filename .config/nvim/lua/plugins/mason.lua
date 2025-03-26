return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
