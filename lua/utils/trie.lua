local func = require("utils.func")
local types = require("utils.types")
local pkg = {}
local priv = {}

types.define_metafield(_G, "type")
types.define_metafield(_G, "name")

function priv.insert(trie, key, val)
    local curr, head, tail = trie, trie.split(key)
    while type(curr) == "trie" and tail do
        curr.children[head] = curr.children[head] or curr:child{}
        curr = curr.children[head]
        head, tail = curr.split(tail)
    end
    curr.children[head].val = val
end

function priv.get(trie, key)
    local head, tail = trie.split(key)
    local curr = trie
    while curr and tail do
        curr = rawget(curr.children, head)
        head, tail = curr and curr.split(tail)
    end
    return curr and rawget(curr.children, head)
end

function priv.leaves(trie)
    local function leaves_gen(t, ...)
        for k, v in pairs(t.children) do
            if v._istrie then
                leaves_gen(v, k, ...)
            else
                coroutine.yield(v, table.pack(k, ...))
            end
        end
    end
    return coroutine.wrap(function() leaves_gen(trie) end)
end

function priv.repr_lines(trie, prefix)
    local lines = {}
    if type(trie) == "trie" then
        if prefix == nil or prefix:len() == 0 then
            table.insert(lines, trie.name or name(trie))
            prefix = " "
        end
        for k, v in pairs(trie.children) do
            if next(trie.children, k) then
                local new_pre = prefix .. "|"
            else
                local new_pre = prefix .. " "
            end
            table.insert(lines, new_pre .. "\\")
            table.insert(lines, new_pre .. k)
            table.insert(lines, priv.repr_lines(v, new_pre))
        end
    else
        table.insert(lines, prefix .. trie)
    end
    return table.concat(lines, "\n")
end

priv.mt = {
    __name = "Trie",
    __tostring = priv.repr_lines,
    __index = priv.get,
    __newindex = priv.insert,
    __type = "trie",
    __pairs = nil,
}

priv.split = function (key)
    if type(key) == "table" then
        return key[1], table.pack(table.unpack(key, 2))
    elseif type(key) == "string" then
        local pos = key:find("[/.%s]")
        if pos then
            return key:sub(1, pos - 1), key:sub(pos + 1)
        else
            return key, nil
        end
    end
end

priv.child = function (trie, args)
    args = args or {}
    args.split = trie.split
    args.child = trie.child
    return pkg.new(args)
end

priv.merge = function (t1, t2, strategy)

end

function pkg.new(args)
    setmetatable(args, priv.mt)
    args.split = args.split or priv.split
    args.child = args.child or priv.child
    args.children = {}
    setmetatable(args, priv.mt)
    return args
end

pkg.priv = priv
return pkg
