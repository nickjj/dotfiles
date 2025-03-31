-- Keymaps are automatically loaded on the VeryLazy event.
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

DEL("n", "<leader>l")
MAP("n", "<leader>ll", "<Cmd>Lazy<CR>", { desc = "Lazy" })
MAP("n", "<leader>lL", "<Cmd>LazyExtras<CR>", { desc = "Lazy Extras" })

MAP(
  "n",
  "<C-Down>",
  "<Cmd>execute 'move .+' . v:count1<CR>==",
  { desc = "Move Down" }
)
MAP(
  "n",
  "<C-Up>",
  "<Cmd>execute 'move .-' . (v:count1 + 1)<CR>==",
  { desc = "Move Up" }
)
MAP("i", "<C-Down>", "<esc><Cmd>m .+1<CR>==gi", { desc = "Move Down" })
MAP("i", "<C-Up>", "<esc><Cmd>m .-2<CR>==gi", { desc = "Move Up" })
MAP(
  "x",
  "<C-Down>",
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv",
  { desc = "Move Down" }
)
MAP(
  "x",
  "<C-Up>",
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv",
  { desc = "Move Up" }
)

MAP({ "n", "x" }, "x", '"_x', { desc = "Delete Chars Into Void" })
MAP({ "n", "x" }, "X", '"_x', { desc = "Delete Chars Into Void" })
MAP({ "n", "x" }, "<Del>", '"_x', { desc = "Delete Chars Into Void" })

MAP("x", "y", "ygv<Esc>", { desc = "Yank Preserve Cursor" })
MAP("x", "p", "P", { desc = "Paste Without Override" })

MAP("n", "<leader>uW", ":set list!<CR>", { desc = "Toggle WhiteSpace" })

MAP("n", "<leader>bc", ":let @+ = expand('%:.')<CR>", { desc = "Copy Path" })

MAP(
  "x",
  "gt",
  "c<C-r>=system('tcc', getreg('\"'))[:-2]<CR>",
  { desc = "Titleize Text" }
)
