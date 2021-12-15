local pkg = {}

local private = {
    const = {
        has_child = " => ",
        is_child_of = " <= ",
    },
    tbls = {N=0},
}

-- Naming convention used by cache table and print/format fns
function private.get_tableref_name(tab)
    return "<T" .. private.tbls[tab] .. ">"
end

function private.cache_tableref(tab)
    assert(type(tab) == "table")
    if not private.tbls[tab] then
        private.tbls.N = private.tbls.N + 1
        private.tbls[tab] = private.tbls.N
    end
end

private.indent = function(str)
    return string.gsub(str, "\n", "\n" .. "  ")
end

function private.fmt_key(key)
    if not (type(key) == "table") then
        return "[" .. private.fmt_val(key) .. "]"
    else
        private.cache_tableref(key)
        return private.get_tableref_name(key)
    end
end

function private.fmt_val(val)
    local _t = type(val)
    if _t == "string" then
        return string.format("%q", val)
    elseif _t == "table" then
        private.cache_tableref(val)
        local lines = {}
        for k,v in pairs(val) do
            table.insert(lines, private.fmt_key(k) .. private.const.has_child .. private.indent(private.fmt_val(v)))
        end
        return "{\n  " .. table.concat(lines, ",\n  ") .. "\n}"
    elseif _t == "number" then
        return val
    end
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

pkg.private = private
return pkg
