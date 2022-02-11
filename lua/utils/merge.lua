--- Merge src into dest.
-- @param dest Object to merge into (assigned src's value if nil)
-- @param source Contains "udpates" to dest; no effect if nil
-- @param force_if Predicate with signature force_if :: Atom -> Atom -> Bool.  Should return true iff src atom (second arg) should replace dest atom in case of conflict.
-- NOTE: Mutates dest if dest is a table
local function merge(dest, src, force)
    if not (dest and src) then
        dest = dest or src
        return dest
    else
        assert(type(dest) == type(src), "Merged objects must have the same type")
        if type(src) == "table" then
            for key, subtree in pairs(src) do
                local ret = merge(dest[key], subtree)
                if ret then dest[key] = ret end
            end
        elseif force then
            return src
        else
            return dest
        end
    end
end
