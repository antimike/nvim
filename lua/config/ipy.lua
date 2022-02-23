vim.g.nvim_ipy_perform_mappings = 0
vim.g.ipy_celldef = '^##'
-- Set ft of output to kernel language
-- Might interact poorly with filetype syntax highlighting
vim.g.ipy_set_ft = 0
-- Highlight ANSI sequences in output
vim.g.ipy_highlight = 1
-- Cap number of lines echoed to kernel
vim.g.ipy_truncate_input = 0
vim.g.ipy_shortprompt = 0

-- Support R-markdown
-- TODO: Convert this to Lua
vim.cmd [[
au FileType rmd let b:ipy_celldef = ['^```{r}$', '^```$']
]]
