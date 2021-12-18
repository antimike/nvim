local pkg = {}

--- Sorts pairs of passed args.
--  Sorts first two args using a passed comparator function (optional; defaults to <=).
--  Optionally accepts a default value to use in case of nil values.
--  Returns min and max in order, along with a bool to indicate if swap was performed.
--  If default is not provided, nil values are always treated as "less than or equal to" other values.
-- @param a First item to sort
-- @param b Second item to sort
-- @param default Default value to assign in case of nil values
-- @param leq Comparator function to use
-- @return Min value of pair
-- @return Max value of pair
-- @return Bool indicating whether swap was performed
pkg.sort_pair = function (a, b, default, leq)
    a = a or default
    b = b or default
    leq = leq or function (x,y) return x<=y end
    if not a then
        return a, b, false
    elseif not b then
        return b, a, true
    elseif leq(a, b) then
        return a, b, false
    else
        return b, a, true
    end
end

return pkg
