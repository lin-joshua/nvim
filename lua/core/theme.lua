local M = {}

function M.setup()
    vim.o.background = "dark"
    -- Dracula+ (matches Ghostty's built-in "Dracula+" theme)
    require("dracula").setup({
        colors = {
            bg = "#212121",
            yellow = "#FFCB6B",
            bright_yellow = "#FFCB6B",
            purple = "#C792EA",
            -- neutral grays instead of Dracula's purple-tinted ones
            selection = "#3A3A3A",
            visual = "#3A3A3A",
            menu = "#2A2A2A",
            black = "#1A1A1A",
        },
    })

    vim.cmd.colorscheme("dracula")
end

return M
