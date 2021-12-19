local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

-- Sets vim option given desired scope and value
function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

-- Maps lhs --> rhs given mode and opts
function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Concatenates passed lists
function utils.concat(...)
    local args = {...}
    local ret = {}
    for _,tab in ipairs(args) do
        table.move(tab, 1, #tab, #ret+1, ret)
    end
    return ret
end

-- Convenience function to produce a valid vim command from a fully-qualified Lua function name
function utils.make_vim_cmd(lua_fncname)
    local mod, fnc = lua_fncname:match'^(.*)%.([^%.]+)$'
    return ":lua require" .. "'" .. mod .. "'" .. "." .. fnc .. "()"
end

return utils
