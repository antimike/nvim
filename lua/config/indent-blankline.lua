local indent_blankline_styles = {
  line_left = "▏",
  long_dash = "¦",
  short_dash = "┆",
  line_center = "│",
  thin_line_left = "⎸",
  short_line_center = "|",
}
-- Disable indent-blankline on these pages.
vim.g.indent_blankline_filetype_exclude = {
  "help",
  "terminal",
  "dashboard",
  "packer",
  "vista",
  "TelescopePrompt",
  "lsp-installer",
  "lspinfo",
  "vista_kind",
  "NvimTree",
  "calendar",
  "peek",
  "dhall",
}
vim.g.indent_blankline_buftype_exclude = {
  "terminal",
  'lsp-installer',
  'lspinfo',
  "TelescopePrompt",
  "nofile",
}

vim.g.indent_blankline_char = indent_blankline_styles.short_dash
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_char = indent_blankline_styles.short_dash
vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
