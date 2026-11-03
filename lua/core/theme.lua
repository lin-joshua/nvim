local M = {}

-- Rex's "Merino" theme is GitHub's Primer palette
-- (merino-dark = GitHub Dark Default, merino-light = GitHub Light Default)
local schemes = {
    dark = "github_dark_default",
    light = "github_light_default",
}

-- loading a github scheme flips 'background' itself; ignore those nested
-- OptionSet events so dark/light don't ping-pong forever
local switching = false

local function apply(bg)
    switching = true
    vim.cmd.colorscheme(schemes[bg or vim.o.background] or schemes.dark)
    switching = false
end

function M.setup()
    require("github-theme").setup({})

    -- nvim detects the terminal background, so this follows Rex's dark/light switch
    apply()
    vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        -- defer so nvim finishes reloading the old scheme before we swap
        callback = function()
            if switching then return end
            local bg = vim.v.option_new
            vim.schedule(function()
                if vim.g.colors_name ~= schemes[bg] then apply(bg) end
            end)
        end,
    })
end

return M
