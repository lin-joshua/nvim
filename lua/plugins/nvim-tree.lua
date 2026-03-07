-- lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeCollapse",
  },

  -- Run before the plugin loads (important for netrw)
  init = function()
    -- Disabling netrw is strongly advised by nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,

  -- Lazy will pass this table to require("nvim-tree").setup(opts)
  opts = {
    view = {
      width = 35,
      side = "left",
      signcolumn = "yes",
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    filters = {
      dotfiles = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
  },

  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}

