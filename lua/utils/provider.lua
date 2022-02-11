-- local merge = require("utils.merge")
--- Template and functions to support preference-ranked capability providers.

local weak_key_mt = {__mode = "k"}
local weak_val_mt = {__mode = "v"}
--- Table of capability providers.
-- Holds two sets of associations:
--  1. Provider tables to numerical preferences (higher rankings are preferred);
--  2. Service tables (i.e., subtables of `Services`) to provider tables
-- The table is weakly keyed in order to enable garbage collection of unused tables.
-- NOTE: This table is global.
Providers = {}
--- Table of services to be provided.
-- Leaves consist of empty tables which index into the `Providers` and `Keybindings` tables.
-- The table is weakly-valued in order to enable garbage collection of unused tables.
-- TODO: Enforce this structure with a constructor
-- NOTE: This table is global.
Services = {}
setmetatable(Providers, weak_key_mt)
setmetatable(Services, weak_val_mt)

-- TODO: Add some asserts
-- TODO: Add docs
function Providers:add(service, rank)
    if not Providers[service] or Providers[Providers[service]] < rank then
        Providers[self] = rank
        Providers[service] = self
    end
end

--- Prototype for a "pointer tree" whose leaves are used to index into other tables.
Pointree = {
    new = function(tab, meta)   -- meta arg allows weak Pointrees
        assert(type(tab) == "table")
        meta = meta or {}
        meta.__index = Pointree
        setmetatable(tab, meta)
        return tab
    end,
    ensure_path = function(self, ...)
        local path = {...}
        local root = self
        for i=1,#path do
            local child = path[i]
            root[child] = root[child] or {}
            root = root[child]
        end
        return root
    end,
    insert_at = function(self, val, ...)
        local root = self:ensure_path(...)
        local ptr = {}
        root[val] = ptr
        return ptr
    end,
    index_with = function(self, idx_name, idx)
        error("Not implemented")
    end,

}


--function Services:add(...)
--    local path = {...}
--    local root = Services
--    for _, child in ipairs(path) do
--        root[child] = root[child] or {}
--        root = root[child]
--    end
--
--    merge.merge_trees(root, self)
--end
