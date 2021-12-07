-- Define functions to set options at a given scope and configure keymaps
local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.concat(...)
    local args = {...}
    local ret = {}
    for _,tab in ipairs(args) do
        table.move(tab, 1, #tab, #ret+1, ret)
    end
    return ret
end

return utils
