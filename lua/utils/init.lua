local vimutils = require("utils.vimutils")

-- Concatenates passed lists
function vimutils.concat(...)
    local args = {...}
    local ret = {}
    for _,tab in ipairs(args) do
        table.move(tab, 1, #tab, #ret+1, ret)
    end
    return ret
end
return vimutils
