vim.opt.encoding = "UTF-8" -- Standard encoding
vim.opt.number = true -- Line numbering
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.wrap = false -- No line wrapping
vim.opt.hlsearch = true -- Highlight search results
vim.opt.termguicolors = true -- Enable true color support
vim.opt.belloff = "all" -- Stop annoying bell sounds

-- Make tabs & indentation consistent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Other global variables from your vimrc
vim.g.tex_indent_items = 0
vim.g.pyindent_open_paren = "shiftwidth()"

-- Filetype specific settings can be done with autocommands (see legacy.lua)
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- Remember cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
})

vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python")

-- Molten configuratiosn
vim.g.molten_virt_text_output = true
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_max_lines = 12
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_image_location = "virt"
vim.g.molten_cover_empty_lines = false
