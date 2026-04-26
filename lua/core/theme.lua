local M = {}

function M.setup()
  vim.o.background = "dark"
  require("catppuccin").setup({
      flavour = "mocha",
  })

  vim.cmd.colorscheme("catppuccin")
end

return M
