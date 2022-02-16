-- indent-blankline character.
vim.g.indent_blankline_char = "▏"

-- Disable indent-blankline on these pages.
vim.g.indent_blankline_filetype_exclude = {
  "help",
  "terminal",
  "dashboard",
  "packer",
  "vista",
}
vim.g.indent_blankline_buftype_exclude = {
  "terminal",
  'lsp-installer',
  'lspinfo'
}

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = true

require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}
