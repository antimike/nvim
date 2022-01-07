-- TODO: Implement virtual inheritance (i.e., "common base class")---virtual ancestors can only appear once in a descendant's ancestor hierarchy
function get_metafield(obj, name)
    local mt = getmetatable(obj)
    return mt and rawget(mt, name)
end

function define_metafield(env, name, default, metaname)
    metaname = metaname or "__" .. name
    local accessor = rawget(env, name)
    if accessor then
        local backup_name = "raw" .. name
        while rawget(env, backup_name) do
            backup_name = "_" .. backup_name
        end
        rawset(env, backup_name, accessor)
    end
    local function new_accessor(obj)
        if obj then
            return get_metafield(obj, metaname) or (accessor and accessor(obj)) or default
        else
            return nil
        end
    end
    rawset(env, name, new_accessor)
end

define_metafield(_G, "type", "object")
define_metafield(_G, "name")
define_metafield(_G, "super")

function dfs(tree, key, eval)
    eval = eval or rawget
    local ret = eval(tree, key)
    local k, v = next(tree, nil)
    while ret == nil do
        ret = dfs(next)
    end
end

function bfs(tree, key, depth)
    if depth <= 0 then
        return tree[key]
    else
        local k, v = next(tree, nil)
        while k ~= key do
            ret = 
        end
    end
end

Class = {}

-- Metatable of "Class" metaclass itself
local class_mt = {
    __call = function (cls, obj)
        obj.__mt = obj.__mt or {
            __index = obj,
            __type = obj,
        }
        setmetatable(obj.__mt, {__index = cls.__mt})
        setmetatable(obj, cls.__mt)
        return obj
    end,
    __name = "Class",
    __type = "class",
}
setmetatable(Class, class_mt)

-- Metatable assigned to instances
Class.__mt = {
    __index = function (obj, key)
        local curr = obj
    end,
    __type = "class",
    __index = Class,
    __call = function (cls, obj)
        setmetatable(obj, cls)
        return obj
    end
}

-- Metatable assigned to subclasses
Class.__sub_mt = {
    __index = function (sub, key)
    end
}

-- TODO: Implement (stateless?) iterator over ancestors for a given property / method
function super(obj, prop)
    local curr = obj
    while not rawget(curr, prop) do
    end
end

function instance(class, obj)
    return setmetatable(obj, {__index = class})
end

function class(obj, ...)
    -- Private / public fields
    -- Methods
    local mt = {
        __type = name,
        __index = defaults
    }
    return function (obj)
        return setmetatable(obj, mt)
    end
end
