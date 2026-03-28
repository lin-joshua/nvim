-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set

-- Have j and k navigate visual lines rather than logical ones
keymap("n", "j", "gj")
keymap("n", "k", "gk")
keymap("v", "j", "gj")
keymap("v", "k", "gk")

-- Use H and L for beginning/end of line
keymap("n", "H", "^")
keymap("n", "L", "$")
keymap("v", "H", "^")
keymap("v", "L", "$")

-- File explorer (nvim-tree)
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>T", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })

