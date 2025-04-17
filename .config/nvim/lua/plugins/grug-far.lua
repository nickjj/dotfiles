return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "grug-far" },
      callback = function()
        MAP({ "i", "n", "x" }, "<A-h>", function()
          local state = unpack(
            require("grug-far").toggle_flags({ "--hidden", "--glob !.git/" })
          )
          vim.notify(
            "grug-far: toggled --hidden --glob !.git/ "
              .. (state and "ON" or "OFF")
          )
        end, { desc = "Toggle Hidden Files", buffer = true })

        MAP({ "i", "n", "x" }, "<A-i>", function()
          local state =
            unpack(require("grug-far").toggle_flags({ "--no-ignore" }))
          vim.notify(
            "grug-far: toggled --no-ignore " .. (state and "ON" or "OFF")
          )
        end, { desc = "Toggle Ignored Files", buffer = true })
      end,
    })
  end,
  init = function()
    MAP(
      "x",
      "<leader>sRa",
      ":lua require('grug-far').with_visual_selection()<CR>",
      { desc = "All Files" }
    )

    MAP(
      "n",
      "<leader>sRc",
      ":lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<CR>",
      { desc = "Current File" }
    )

    MAP(
      "x",
      "<leader>sRc",
      ":lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<CR>",
      { desc = "Current File" }
    )

    MAP(
      "x",
      "<leader>sRw",
      "<Cmd>GrugFarWithin<CR>",
      { desc = "Within Range" }
    )
  end,
}
