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
        "pyright",
        "ruff",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = {
          spacing = 2,
          source = "if_many",
        },
        float = {
          border = "rounded",
          source = true,
        },
      })

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

      vim.lsp.config("pyright", {
        capabilities = capabilities,
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
      local format_group = vim.api.nvim_create_augroup("UserLspFormat", { clear = true })

      local function apply_source_action(bufnr, action)
        local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ruff" })
        for _, client in ipairs(clients) do
          if client:supports_method("textDocument/codeAction", bufnr) then
            local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
            params.context = {
              diagnostics = {},
              only = { action },
            }

            local response = client:request_sync("textDocument/codeAction", params, 3000, bufnr)
            for _, code_action in ipairs(response and response.result or {}) do
              if not code_action.edit and client.server_capabilities.codeActionProvider.resolveProvider then
                local resolved = client:request_sync("codeAction/resolve", code_action, 3000, bufnr)
                code_action = resolved and resolved.result or code_action
              end
              if code_action.edit then
                vim.lsp.util.apply_workspace_edit(code_action.edit, client.offset_encoding)
              end
              if code_action.command then
                client:request_sync("workspace/executeCommand", code_action.command, 3000, bufnr)
              end
            end
          end
        end
      end

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
          keymap("n", "[d", vim.diagnostic.goto_prev, opts_for_buffer("Previous diagnostic"))
          keymap("n", "]d", vim.diagnostic.goto_next, opts_for_buffer("Next diagnostic"))
          keymap("n", "<leader>d", vim.diagnostic.open_float, opts_for_buffer("Line diagnostics"))

          if client:supports_method("textDocument/formatting", bufnr) then
            vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = format_group,
              buffer = bufnr,
              callback = function()
                if vim.bo[bufnr].filetype == "python" then
                  apply_source_action(bufnr, "source.organizeImports.ruff")
                end
                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
              end,
            })
          end
        end,
      })

      require("mason-lspconfig").setup(opts)
    end,
  },
}
