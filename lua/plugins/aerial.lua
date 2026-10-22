-- Symbol outline (classes, functions, ...) in a side panel, toggled with <leader>a.
-- Python symbols come from basedpyright since nvim-treesitter isn't installed.
return {
  "stevearc/aerial.nvim",
  cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
  },
}
