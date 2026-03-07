-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    -- "EdenEast/nightfox.nvim",
    "folke/tokyonight.nvim",
    lazy = false,        -- make sure we load this during startup
    priority = 1000,     -- make sure to load this before other plugins
    opts = {},
  },
}
