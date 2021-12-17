-- Implements a priority queue using a binomial heap
local zip = require("utils.zip")

local Q = {}
local Q_priv = {}
Q_priv.mt = {__index = Q}

function Q:new(leq)
    local ret = {
        order = 0,
        max = 0,
        len = 0,
        subqs = {},
        parent = parent,
    }
    setmetatable(ret, Q_priv.mt)
    return ret
end

