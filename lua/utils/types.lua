-- TODO: Implement virtual inheritance (i.e., "common base class")---virtual ancestors can only appear once in a descendant's ancestor hierarchy
local func = require("utils.func")
local priv = {}

local metafields = {}

-- @param obj Object whose metafield should be fetched
-- @param name Name of metafield
-- @return Value of metatable[name]
function priv.get_metafield(obj, name)
    local mt = getmetatable(obj)
    return mt and rawget(mt, name)
end

--- Setup object to inherit ancestor tables' properties.
-- @param obj Descendant object (i.e., "inheritor").  If nil, new object is assigned
-- @param ... Ancestors to inherit from
-- @return Object with inheritance from specified ancestors
function priv.inherit_from(obj, ...)
    obj = obj or {}
    local mt = getmetatable(obj) or {}
    mt.__index = func.switch(mt.__index, ...)
    return setmetatable(obj, mt)
end

--- Ensure an object's metatable is unique and return it.
-- @param obj Object to create and fetch unique metatable for
-- @return Unique metatable for obj
function priv.own_metatable(obj)
    local mt = getmetatable(obj)
    mt = mt and priv.inherit_from({}, mt) or {}
    setmetatable(obj, mt)
    return mt
end

--- Define a metafield access function with behavior similar to `type` on the specified environment.
-- The created metafield will correspond to a key in each table's metatable.
-- If env[name] already exists, its original value will be renamed to "raw" .. env[name].
-- @param env Environment in which to define metafield.  Defaults to _G
-- @param name Name of metafield accessor function to define (e.g., "type" for __type metafield)
-- @param default Default value of metafield
-- @param metaname Key of metatable corresponding to metafield.  Defaults to "__" .. name
function priv.define_metafield(env, name, default, metaname)
    env = env or _G
    if not metafields[env] or not metafields[env][name] then
        metaname = metaname or "__" .. name
        local accessor = rawget(env, name)
        if accessor then
            local backup_name = "raw" .. name
            rawset(env, backup_name, rawget(env, backup_name) or accessor)
        end
        metafields[env] = metafields[env] or {}
        metafields[env][name] = {
            metaname = metaname,
            default = default,
            accessor = func.switch(func.curry(priv.get_metafield, nil, metaname), accessor, {metaname = default})
        }
        rawset(env, name, metafields[env][name].accessor)
    end
end

return priv
