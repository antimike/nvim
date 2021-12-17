local Z = {}

local function zip_ipairs_iter(lists, idx)
    idx = idx + 1
    local ret, vals, val = false, {}, nil
    for _,l in ipairs(lists) do
        val = l[idx]
        ret = ret or val
        table.insert(vals, val)
    end
    if ret then
        return idx, table.unpack(vals)
    end
end

function Z.zip_ipairs(...)
    local args = {...}
--    io.stderr:write(...)
    return zip_ipairs_iter, args, 0
end

return Z
