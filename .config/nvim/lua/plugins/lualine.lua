local function wordcount()
  local label = "word"
  local word_count = 0

  if vim.fn.mode():find("[vV]") then
    word_count = vim.fn.wordcount().visual_words
  else
    word_count = vim.fn.wordcount().words
  end

  if word_count > 1 then
    label = label .. "s"
  end

  return word_count .. " " .. label
end

local function readingtime()
  -- 200 is about the average words read per minute.
  return tostring(math.ceil(vim.fn.wordcount().words / 200.0)) .. " min"
end

local function is_prose()
  return vim.bo.filetype == "markdown" or vim.bo.filetype == "text"
end

local function location()
  -- This function existed in Lualine, I modified it to display the total
  -- number of selected characters spanning across multiple lines.
  local line = vim.fn.line(".")
  local col = vim.fn.charcol(".")

  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")

  if vim.fn.mode():find("[vV]") and line_end ~= line_start then
    return string.format(
      "%d:%d:%d",
      line,
      col,
      vim.fn.wordcount().visual_chars
    )
  else
    return string.format("%d:%d", line, col)
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { location, padding = { left = 0, right = 1 } },
        },
        -- Disable the default clock and replace it with word stats.
        lualine_z = {
          { wordcount, cond = is_prose },
          { readingtime, cond = is_prose },
        },
      },
    },
  },
}
