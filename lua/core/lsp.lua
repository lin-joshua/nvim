-- Python language server (hover docs, signature help, go-to-definition).
-- Needs `basedpyright` on PATH: `uv tool install basedpyright`.

-- Pick the interpreter whose site-packages the server should resolve imports
-- against: the active venv, else the project's .venv, else whatever is on PATH.
local function python_path(root_dir)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  end
  if root_dir then
    local venv_python = root_dir .. "/.venv/bin/python"
    if vim.uv.fs_stat(venv_python) then
      return venv_python
    end
  end
  return vim.fn.exepath("python3")
end

vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", ".git" },
  before_init = function(_, config)
    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
      python = { pythonPath = python_path(config.root_dir) },
    })
  end,
  settings = {
    basedpyright = {
      -- Docs and signatures only; leave linting to a dedicated tool.
      analysis = { typeCheckingMode = "off" },
    },
  },
})

vim.lsp.enable("basedpyright")
