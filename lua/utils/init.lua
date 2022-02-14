local found, wk = pcall(require, "which-key")
if not found then
  return require("utils.map_basic")
end

local pkg = {}
local trie = {}

function pkg.ClassFactory(props)
  props.__mt = {
    __index = props
  }
  function props.new(obj)
    obj = obj or {}
    setmetatable(obj, props.__mt)
  end
  return props
end


-- local MapOpts = pkg.ClassFactory{
--   mode = "n",
--   prefix = "",
--   buffer = nil,
--   silent = true,
--   noremap = true,
--   nowait = true,
-- }
function BuildMapOpts(first, second)
  if second == nil then
    second = first or {}
    first = {
      mode = "n",
      prefix = "",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }
  end
  return vim.tbl_extend("force", first, second)
end

function get_map_opts(path)
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

--- Linked list showing inherited prefixes and options
function pkg.map(tab)
  local summary = tab.summary
end

return pkg
