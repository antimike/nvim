local pkg = {}

local private = {
    const = {
        has_child = " => ",
        is_child_of = " <= ",
        indent = "  ",
        delimiter = ",",
    },
    tbls = {
        default_next = coroutine.wrap(function()
            local N = 0
            while true do
                N = N + 1
                coroutine.yield("T" .. N)
            end
        end),
    },
}

-- Naming convention used by cache table and print/format fns
function private.fmt_tableref_name(tab)
    local name = tab
    if type(name) == "table" then
        name = private.cache_tableref(name)
    end
    return "<" .. name .. ">"
end

function private.cache_tableref(tab, name)
    assert(type(tab) == "table")
    if name or not private.tbls[tab] then
        name = name or private.tbls.default_next()
        assert(type(name) ~= "table", "Tree names must be scalar types")
        assert(not private.tbls[name], "Tree '" .. name .. "' already exists in the cache!")
        private.tbls[tab] = name
        private.tbls[name] = tab
    end
    return private.tbls[tab]
end

private.indent = function(str)
    return string.gsub(str, "\n", "\n" .. private.const.indent)
end

function private.fmt_key(key)
    if not (type(key) == "table") then
        return "[" .. private.fmt_val(key) .. "]"
    else
        return private.fmt_tableref_name(key)
    end
end

function private.fmt_val(val)
    local _t = type(val)
    if _t == "string" then
        return string.format("%q", val)
    elseif _t == "table" then
        local open, close, elems = private.fmt_tableref_name(val) .. ":" .. "{", "}", ""
        for k,v in pairs(val) do
            elems = elems .. "\n" .. private.const.indent .. private.fmt_key(k) .. private.const.has_child .. private.indent(private.fmt_val(v)) .. private.const.delimiter
        end
        if string.sub(elems, -1) == private.const.delimiter then
            elems = elems .. "\n"
        end
        return open .. elems .. close
    elseif _t == "number" then
        return val
    end
end

function pkg.name(tab)
    return private.tbls[tab]
end

function pkg.get(name)
    return private.tbls[name]
end

pkg.leaves = function (tab)
    local function leaves_gen(t, ...)
        for k,v in pairs(t) do
            if type(v) == "table" and next(v) then
                leaves_gen(v, k, ...)
            else
                coroutine.yield(v, table.pack(k, ...))
            end
        end
    end
    return coroutine.wrap(function () leaves_gen(tab) end)
end

pkg.print_leaves = function (tab)
    for val, path in pkg.leaves(tab) do
        local str = private.fmt_val(val)
        for _, k in ipairs(path) do
            str = str .. private.const.is_child_of .. private.fmt_key(k)
        end
        print(str)
    end
end

function pkg.print(x)
    print(private.fmt_val(x))
end

function pkg.new(tab, name, meta)   -- meta arg allows passing other metamethods besides __index
    assert(type(tab) == "table")
    meta = meta or {}
    meta.__index = pkg
    setmetatable(tab, meta)
    private.cache_tableref(tab, name)
    return tab
end

function pkg.touch_leaf(self, ...)
    local path = {...}
    local root = self
    for i=1,#path do
        local child = path[i]
        root[child] = root[child] or {}
        root = root[child]
    end
    return root
end

function pkg.touch_leaf_reverse(self, ...)
    local path = {...}
    local root = self
    for i=#path,1,-1 do
        local child = path[i]
        root[child] = root[child] or {}
        root = root[child]
    end
    return root
end

function pkg.insert(self, val, ...)
    local node = self:touch_leaf(...)
    node[val] = {}
    return node[val]
end

function pkg.insert_reverse(self, val, ...)
    local node = self:touch_leaf_reverse(...)
    node[val] = {}
    return node[val]
end

function pkg.index_with(self, idx_name, idx)
    error("Not implemented")
end

pkg.private = private
return pkg
