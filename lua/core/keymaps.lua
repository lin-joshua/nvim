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

-- Interactive execution (Molten) 
keymap("n", "<leader>mi", "<cmd>MoltenInit<CR>", { desc = "Molten init" })

keymap("n", "<leader>ml", "<cmd>MoltenEvaluateLine<CR>", { desc = "Molten eval line" })
keymap("v", "<leader>mv", "<cmd><C-u>MoltenEvaluateVisual<CR>", { desc = "Molten eval visual" })

keymap("n", "<leader>mo", "<cmd>MoltenEvaluateOperator<CR>", { desc = "Molten eval operator" })

keymap("n", "<leader>mr", "<cmd>MoltenReevaluateCell<CR>", { desc = "Molten reevaluate cell" })
keymap("n", "<leader>md", "<cmd>MoltenDelete<CR>", { desc = "Molten delete cell" })

keymap("n", "<leader>mx", "<cmd>MoltenInterrupt<CR>", { desc = "Molten interrupt" })
keymap("n", "<leader>mR", "<cmd>MoltenRestart<CR>", { desc = "Molten restart kernel" })
