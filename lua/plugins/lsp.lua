return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ruff",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      vim.diagnostic.enable(false)

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      })

      vim.lsp.config("ruff", {
        capabilities = capabilities,
        init_options = {
          settings = {
            configurationPreference = "filesystemFirst",
            configuration = {
              ["line-length"] = 120,
              format = {
                ["skip-magic-trailing-comma"] = true,
              },
            },
          },
        },
      })

      local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_group,
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          local bufnr = event.buf
          local keymap = vim.keymap.set
          local opts_for_buffer = function(desc)
            return { buffer = bufnr, desc = desc }
          end

          keymap("n", "K", vim.lsp.buf.hover, opts_for_buffer("LSP hover"))
          keymap("n", "gd", vim.lsp.buf.definition, opts_for_buffer("Go to definition"))
          keymap("n", "gD", vim.lsp.buf.declaration, opts_for_buffer("Go to declaration"))
          keymap("n", "gi", vim.lsp.buf.implementation, opts_for_buffer("Go to implementation"))
          keymap("n", "gr", vim.lsp.buf.references, opts_for_buffer("Find references"))
          keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts_for_buffer("Code action"))
          keymap("n", "<leader>rn", vim.lsp.buf.rename, opts_for_buffer("Rename symbol"))
          keymap({ "n", "v" }, "<leader>f", function()
            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
          end, opts_for_buffer("Format buffer"))
        end,
      })

      require("mason-lspconfig").setup(opts)
    end,
  },
}
