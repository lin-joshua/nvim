return {
  "github/copilot.vim",
  enabled = true,
  event = "VeryLazy",
  config = function()
    vim.g.copilot_enabled = false
    vim.g.copilot_no_tab_map = true
  end,
}
