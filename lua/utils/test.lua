-- Removes cached version of package and loads new one
function reload(pkg)
    package.loaded[pkg] = nil
    return require(pkg)
end

-- Sets dest to the empty table and copies all elements of src to it
-- Useful for backing up and restoring environment tables when testing
function backup(tbl)
    local ret = {}
    for k, v in pairs(tbl) do
        rawset(ret, k, v)
    end
    return ret
end

function restore(src, dest)
    dest = {}
    for k, v in pairs(src) do
        rawset(dest, k, v)
    end
end

function setup_testbed(env)
    env.test = {}
    env.mt = {
        __name = "TEST",
        __type = "test",
        __class = "hellbeast"
    }
    setmetatable(env.test, env.mt)
end

function print_table(tab)
    for k, v in pairs(tab) do
        print(k, v)
    end
end
