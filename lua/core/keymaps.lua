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
keymap("v", "<leader>mv", "<cmd>MoltenEvaluateVisual<CR>", { desc = "Molten eval visual" })
keymap("n", "<leader>mo", "<cmd>MoltenEvaluateOperator<CR>", { desc = "Molten eval operator" })

local function is_percent_marker(line)
  return line:match("^%s*#%s*%%%%%s*$") ~= nil
end

local function molten_eval_percent_cell()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local last = vim.api.nvim_buf_line_count(0)

  local start_row = 1
  for l = row - 1, 1, -1 do
    if is_percent_marker(vim.fn.getline(l)) then
      start_row = l + 1
      break
    end
  end

  local end_row = last
  for l = row + 1, last do
    if is_percent_marker(vim.fn.getline(l)) then
      end_row = l - 1
      break
    end
  end

  if start_row > end_row then
    return
  end

  vim.fn.setpos("'<", { 0, start_row, 1, 0 })
  vim.fn.setpos("'>", { 0, end_row, 1, 0 })
  vim.cmd("normal! gv")
  vim.cmd("MoltenEvaluateVisual")
end

local function molten_cell_ranges()
  local last = vim.api.nvim_buf_line_count(0)
  local ranges = {}
  local start_row = 1

  for l = 1, last do
    if is_percent_marker(vim.fn.getline(l)) then
      if start_row <= l - 1 then
        table.insert(ranges, { start_row, l - 1 })
      end
      start_row = l + 1
    end
  end

  if start_row <= last then
    table.insert(ranges, { start_row, last })
  end

  return ranges
end

local function molten_run_all_percent_cells()
  for _, range in ipairs(molten_cell_ranges()) do
    vim.fn.MoltenEvaluateRange(range[1], range[2])
  end
end

local function molten_restart_and_run_all()
  local group = vim.api.nvim_create_augroup("MoltenRestartRunAll", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "MoltenKernelReady",
    once = true,
    callback = molten_run_all_percent_cells,
  })

  vim.cmd("MoltenRestart!")
end

keymap("n", "<leader>mc", molten_eval_percent_cell, {
  desc = "Molten eval #%% cell",
})

keymap("n", "<leader>mr", "<cmd>MoltenReevaluateCell<CR>", {
  desc = "Molten reevaluate cell",
})

keymap("n", "<leader>md", "<cmd>MoltenDelete<CR>", {
  desc = "Molten delete cell",
})

keymap("n", "<leader>mx", "<cmd>MoltenInterrupt<CR>", {
  desc = "Molten interrupt",
})

keymap("n", "<leader>mR", molten_restart_and_run_all, {
  desc = "Molten restart kernel and run all #%% cells",
})
