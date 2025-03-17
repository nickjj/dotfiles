return {
  {
    "janko/vim-test",
    init = function()
      vim.cmd([[
        let test#strategy = "neovim"
        let test#python#pytest#executable = "docker compose exec web py.test"
        let test#ruby#rails#executable = "docker compose exec -e RAILS_ENV=test js rails test"
        let test#elixir#exunit#executable = "docker compose exec -e MIX_ENV=test web mix test"
      ]])
    end,
    config = function()
      MAP("n", "<leader>tn", "<Cmd>TestNearest<CR>", { desc = "Test Nearest" })
      MAP("n", "<leader>tf", "<Cmd>TestFile<CR>", { desc = "Test File" })
      MAP("n", "<leader>ta", "<Cmd>TestSuite<CR>", { desc = "Test All" })
      MAP("n", "<leader>tl", "<Cmd>TestLast<CR>", { desc = "Test Last" })
      MAP("n", "<leader>tv", "<Cmd>TestVisit<CR>", { desc = "Test Visit" })
    end,
  },
}
