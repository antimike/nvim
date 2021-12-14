local pkg = {}

local private = {
    const = { eq = " => " },
    tbls = {N=0},
}
function private.cache_table(tab)
    assert(type(tab) == "table")
    if not private.tbls[tab] then private.tbls.N = private.tbls.N + 1
        private.tbls[tab] = "<T" .. private.tbls.N .. ">"
    end
end
private._indent = function(str)
    return string.gsub(str, "\n", "\n" .. "  ")
end
function private._fmt_key(key)
    if not (type(key) == "table") then
        return "[" .. private._fmt_val(key) .. "]"
    else
        private.cache_table(key)
        return private.tbls[key]
    end
end
function private._fmt_val(val)
    local _t = type(val)
    if _t == "string" then
        return string.format("%q", val)
    elseif _t == "table" then
        private.cache_table(val)
        local lines = {}
        for k,v in pairs(val) do
            table.insert(lines, private._fmt_key(k) .. private.const.eq .. private._indent(private._fmt_val(v)))
        end
        return "{\n  " .. table.concat(lines, ",\n  ") .. "\n}"
    elseif _t == "number" then
        return val
    end
end

pkg.leaves = function (tab)
    local function generator()
        local curr = tab
        for k,v in pairs(curr) do
            if type(v) ~= "table" then
                coroutine.yield(k,v)
            else
                pkg.leaves(v)
            end
        end
    end
    return coroutine.wrap(generator)
end

function pkg.print(x)
    print(private._fmt_val(x))
end
pkg.private = private
return pkg
