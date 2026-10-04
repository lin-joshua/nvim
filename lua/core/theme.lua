local M = {}

function M.setup()
    vim.o.background = "dark"
    require("dracula").setup({})

    vim.cmd.colorscheme("dracula")
end

return M
