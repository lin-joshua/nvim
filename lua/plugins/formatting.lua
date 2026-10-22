-- Format on save. Needs `yapf` on PATH: `uv tool install yapf`.
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        python = { "yapf" },
      },
      formatters = {
        -- Google style wrapped at 100 to match the colorcolumn, overriding any project config.
        -- `continuation_align_style: fixed` gives hanging indents (wrapped args indented a fixed
        -- 4 spaces) instead of aligning them with the opening bracket. `split_before_first_argument`
        -- always breaks right after the opening bracket when a call has to wrap, and
        -- `split_before_named_assigns: false` fills each line with keyword args up to the limit.
        yapf = {
          prepend_args = {
            "--style",
            "{based_on_style: google, column_limit: 100, continuation_align_style: fixed, split_before_first_argument: true, split_before_named_assigns: false}",
          },
        },
      },
      -- yapf is much slower than ruff on large files.
      format_on_save = { timeout_ms = 2000 },
    },
  },
}
