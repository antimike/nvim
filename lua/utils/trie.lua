local pkg = {}
local priv = {}

local plugin = {
    provides = {
        search = {
            files = kb("lua_fn"),
            buffers = "some_other_function"
        }
    }
}

priv.leaf = function () return {} end
priv.split = function (key)
    return string.gmatch(key, "[^./]+")
end
priv.mt = {
    __tostring = print,
    __len = function (t) return t.N end,
    __index = pkg,
    __newindex = priv.insert,
}

function pkg.new(leaf_ctor, keysplit)
    local ret = {
        leaf = leaf_ctor or priv.leaf,
        split = keysplit or priv.split,
    }
    local mt = {
        __index = pkg,   -- Set __index = some local table if necessary
    }
    setmetatable(mt, priv.mt)
    setmetatable(ret, mt)
    return ret
end

function priv.insert(trie, key, val)

end
