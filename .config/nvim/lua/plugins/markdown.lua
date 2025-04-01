local data_path = vim.fn.stdpath("config") .. "/lua/plugins/data"
local markdownlint_cli2_path = data_path .. "/.markdownlint-cli2.yaml"
local markdown_preview_css_path = data_path .. "/github-markdown.css"

return {
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_auto_close = false
      vim.g.mkdp_markdown_css = markdown_preview_css_path
    end,
    build = "cd app && yarn install",
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {

          args = { "--config", markdownlint_cli2_path, "--fix", "$FILENAME" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", markdownlint_cli2_path, "--" },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      win_options = {
        colorcolumn = { default = vim.o.colorcolumn, rendered = "" },
      },
      heading = {
        width = "block",
        min_width = tonumber(vim.o.colorcolumn),
      },
    },
  },
}
