local pkg = {}
local priv = {}

function priv.elems_gen(state, ctrl)
    ctrl = ctrl + 1
    if ctrl <= state.max then
        while not state[ctrl] and ctrl < state.max do
            ctrl = ctrl + 1
        end
        return ctrl, state[ctrl]
    end
end

function priv.elems(q)
    local min = q.min or 0
    return priv.elems_gen, q, (min - 1)
end

function priv.tostring(q)
    local ret = {}
    for pri, elem in ipairs(q) do
        table.insert(ret, pri .. ": " .. tostring(elem))
    end
    return table.concat(ret, "\n")
end

priv.mt = {
    __index = pkg,
    __ipairs = priv.elems,
    __len = function (q) return q.N end,
    __tostring = priv.tostring
}

function pkg.new()
    local ret = {}
    ret.N = 0
    ret.min = nil
    ret.max = nil
    setmetatable(ret, priv.mt)
    return ret
end

function pkg.insert(q, elem, pri)
    pri = pri or 1
    if q[pri] then
        table.insert(q, pri, elem)
        q.max = q.max + 1
    else
        q[pri] = elem
    end
    if not q.max or pri > q.max then
        q.max = pri
    end
    if not q.min or pri < q.min then
        q.min = pri
    end
    q.N = q.N + 1
end

function pkg.next(q)
    if #q > 0 then
        local pri, ret = q.min, q[q.min]
        q[pri] = nil
        while q[q.min] == nil and q.min < q.max do
            q.min = q.min + 1
        end
        q.N = q.N - 1
        return ret, pri
    end
end

function pkg.peek(q)
    return q[q.min]
end

pkg.priv = priv
return pkg
