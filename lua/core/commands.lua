-- ~/.config/nvim/lua/core/commands.lua

-- This function replicates the delimiter swapping logic
local function convert_tex_delimiters()
  -- Get the current cursor position to restore it later
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  -- IMPORTANT: Apply Display math conversion FIRST. This is more specific.
  -- $$...$$ → \[...\]
  vim.cmd([[silent! %s/\v\$\$(\_.{-})\$\$/\\[\1\\]/g]])

  -- Apply Inline math conversion with a corrected, more specific pattern
  -- This pattern now requires at least one character between the dollar signs.
  -- $...$ → \(...\)
  vim.cmd([[silent! %s/\$\([^$][^$]*\)\$/\\(\1\\)/g]])

  -- Remove search highlighting
  vim.cmd('nohlsearch')

  -- Restore the original cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- Create the user command :Delimit that calls our Lua function
vim.api.nvim_create_user_command(
  'Delimit',
  convert_tex_delimiters,
  { desc = 'Convert $...$ to \\(...\\) and $$...$$ to \\[...\\]' }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})
