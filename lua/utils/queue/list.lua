local queue = { }

queue.mt = {
    __index = queue,
    __len = function (q) return q.n end,
    __tostring = function (q)
        return table.concat(q, ", ", q.start, q.start + q.n - 1)
    end
}

function queue.new(...)
    local ret = table.pack(...)
    ret.start = 1
    setmetatable(ret, queue.mt)
    return ret
end

function queue.dequeue(q)
    local n, s, ret = rawget(q, "n"), rawget(q, "start")
    if n > 0 then
        ret = rawget(q, s)
        rawset(q, "n", n - 1)
        rawset(q, s, nil)
        rawset(q, "start", s + 1)
    elseif s ~= 1 then
        rawset(q, "start", 1)
    end
    return ret
end

function queue.enqueue(q, ...)
    local args = table.pack(...)
    local s, n = q.start, q.n
    table.move(args, 1, args.n, q.n + q.start, q)
    q.n = q.n + args.n
end

function queue.peek(q)
    return rawget(q, rawget(q, "start"))
end
return queue
