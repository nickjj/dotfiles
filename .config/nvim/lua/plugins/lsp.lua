return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          settings = {
            filetypes = { "sh", "bash", "zsh" },
          },
        },
        rubocop = {
          enabled = false,
        },
      },
    },
  },
}
