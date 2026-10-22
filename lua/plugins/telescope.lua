-- Fuzzy finder for files, grep, buffers, and symbols (via the aerial extension).
-- Aerial is a dependency so it's loaded by the time the extension is registered.
-- Git root of the current file, falling back to the cwd outside a repo.
local function git_root()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" or vim.fn.isdirectory(dir) == 0 then
    return vim.uv.cwd()
  end
  local root = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
  return vim.v.shell_error == 0 and root or vim.uv.cwd()
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/aerial.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files({ cwd = git_root() }) end, desc = "Find files (repo)" },
    { "<leader>fg", function() require("telescope.builtin").live_grep({ cwd = git_root() }) end, desc = "Live grep (repo)" },
    { "<leader>fF", function() require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Find files (file's dir)" },
    { "<leader>fG", function() require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Live grep (file's dir)" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fs", "<cmd>Telescope aerial<CR>", desc = "Symbols in file (aerial)" },
    { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Symbols in project (LSP)" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({})
    pcall(telescope.load_extension, "fzf")
    telescope.load_extension("aerial")
  end,
}
