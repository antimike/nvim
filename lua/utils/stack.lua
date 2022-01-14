local pkg = {}

pkg.mt = {
    __index = pkg,
    __tostring = function (s)
        return table.concat(s, ", ")
    end,
    __len = function (s) return s.n end
}

function pkg.new(...)
    return setmetatable(table.pack(...), pkg.mt)
end

function pkg.push(s, ...)
    local elems = table.pack(...)
    table.move(elems, 1, elems.n, s.n + 1, s)
    s.n = s.n + elems.n
end

function pkg.pop(s)
    local ret = table.remove(s)
    if s.n > 0 then
        s.n = s.n - 1
    end
    return ret
end

function pkg.peek(s)
    return s[#s]
end

return pkg
