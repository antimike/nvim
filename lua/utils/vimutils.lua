local pkg = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g}

-- Sets vim option given desired scope and value
function pkg.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' and scope ~= 'g' then
        scopes.o[key] = value
    end
end

-- Wrapper around vim cmd for setting options
function pkg.set(...)
    vim.cmd(table.concat("set", ...))
end

-- Maps lhs --> rhs given mode and opts
function pkg.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Convenience function to produce a valid vim command from a fully-qualified Lua function name
function pkg.make_vim_cmd(lua_fncname)
    local mod, fnc = lua_fncname:match'^(.*)%.([^%.]+)$'
    return ":lua require" .. "'" .. mod .. "'" .. "." .. fnc .. "()"
end

return pkg;
