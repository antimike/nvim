--- Mapping convenience function that wraps nvim API
local Opts = require("utils.map.opts")

--- Wrapper around vim.api.{nvim_set_keymap,nvim_buf_set_keymap}
local function map(mode, lhs, rhs, opts)
  local vim_opts, buf = Opts.get_vim_opts(opts)
  if buf ~= nil then
    vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, vim_opts)
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, vim_opts)
  end
end

return map
