return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", lsp_format = "first" },
      },
    },
  },
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
        pyright = {
          -- Both settings are to let Ruff handle these tasks.
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                ignore = { "*" },
              },
            },
          },
        },
      },
    },
  },
}
