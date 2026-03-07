return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_diagnostics_ignore = {
      'Overfull \\hbox',
      'Underfull \\hbox',
      'fancyhdr',
      '\\headheight',
    }
  end
}
