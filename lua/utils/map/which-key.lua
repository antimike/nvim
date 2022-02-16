local found, wk = pcall(require, "which-key")
if not found then
  return nil
end

local Opts = require("utils.map.opts")
local trie = {}

-- TODO: Expand this idea (add to WK?)
-- IDEA: Lookup prefixes by human-readable names (e.g., "search/files", etc.)
local function get_map_opts(path)
  local curr, prefix, default = trie, "", nil
  local opts = BuildMapOpts()
  for _, name in ipairs(path) do
    if type(name) == "table" then
      default = name[2]
      name = name[1]
    else
      default = nil
    end
    curr[name] = curr[name] or {keys = default}
    curr = curr[name]
    opts = BuildMapOpts(opts, curr.opts)
    if curr.keys == nil then
      print("Warning: No keybindings for path " .. table.concat(path) .. " were found!")
      return nil
    else
      prefix = prefix .. curr.keys
    end
  end
end

local function map(mode, lhs, rhs, opts)
  local wk_opts = Opts.get_wk_opts(opts)
  error("Not implemented")
end

return map
