return {
  {
    "ntpeters/vim-better-whitespace",
    init = function()
      vim.g.strip_whitespace_confirm = false
      vim.g.strip_whitelines_at_eof = true
      vim.g.strip_whitespace_on_save = true
      vim.g.better_whitespace_filetypes_blacklist = {}

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          vim.cmd([[DisableStripWhitespaceOnSave]])
        end,
      })
    end,
  },
}
