local pkg = {}

local mt = {
    __le = function (a,b)
        if a and b then
            return a.leq(a[0], b[0])
        else
            return not a
        end
    end,
    __index = pkg,
    __add = pkg.merge,
    __concat = pkg.merge,
    __tostring = pkg.print
}

local function gen_subtrees(t, reverse)
    local function rev_iter(_t, idx)
        idx = idx - 1
        if idx > 0 then
            return idx, _t[idx]
        end
    end
    if reverse then
        return rev_iter, t, #t+1
    else
        return ipairs(t)
    end
end

function pkg.factory(leq)
    leq = leq or function (x,y) return x <= y end
    local function new(val, ...)
        local args = {...}
        args.leq = leq
        args[0] = val
        setmetatable(args, mt)
        return args
    end
    return new
end

function pkg.merge(t1, t2)
    -- TODO: Add assert to enforce #t1 == #t2?
    if t1 and t2 then
        local x, y = sort.sort_pair(t1, t2)
        table.insert(y, x)
        return y
    else
        return t1 or t2
    end
end

-- Prints an ASCII representation of a binomial tree
function pkg.print(t, prefix)
    prefix = prefix or ""
    io.stdout:write(prefix, t[0], "\n")
    local first = "|"
    for i=#t, 1, -1 do
        if i == 1 then first = " " end
        io.stdout:write(prefix, first, "\\", "\n")
        pkg.print(t[i], prefix .. first .. " ")
    end
end
