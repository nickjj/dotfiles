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
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        -- Disable the clock.
        lualine_z = {},
        -- Disable the default clock and replace it with word stats.
        lualine_z = {
          { wordcount, cond = is_prose },
          { readingtime, cond = is_prose },
        },
      },
    },
  },
}
