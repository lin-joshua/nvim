return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
    { "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "LSP references" },
  },
  opts = {
    defaults = {
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
      mappings = {
        i = {
          ["<C-h>"] = "which_key",
        },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
  end,
}
