return {
  {
    "ojroques/vim-oscyank",
    branch = "main",
    config = function()
      -- Enable OSC52 for copy-paste
      vim.keymap.set("n", "<leader>c", "<Plug>OSCYankOperator")
      vim.keymap.set("n", "<leader>cc", "<leader>c_")
      vim.keymap.set("v", "<leader>c", "<Plug>OSCYankVisual")
    end,
  },
}
