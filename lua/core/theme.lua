local M = {}

-- Kanagawa, matching Ghostty (dark = Dragon, light = Lotus)
local schemes = {
    dark = "kanagawa-dragon",
    light = "kanagawa-lotus",
}

-- loading a kanagawa scheme flips 'background' itself; ignore those nested
-- OptionSet events so dark/light don't ping-pong forever
local switching = false
-- kanagawa names every variant just "kanagawa", so remember what we applied
local current

local function apply(bg)
    switching = true
    current = schemes[bg or vim.o.background] or schemes.dark
    vim.cmd.colorscheme(current)
    switching = false
end

function M.setup()
    require("kanagawa").setup({
        -- no separate background behind line numbers / sign column
        colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    })

    -- nvim detects the terminal background, so this follows Rex's dark/light switch
    apply()
    vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        -- defer so nvim finishes reloading the old scheme before we swap
        callback = function()
            if switching then return end
            local bg = vim.v.option_new
            vim.schedule(function()
                if current ~= schemes[bg] then apply(bg) end
            end)
        end,
    })
end

return M
