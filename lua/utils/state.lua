local pkg = {}

--- Create a callable object that returns itself merged with its argument when called
function pkg.State(props)
  local __mt = {
    __call = function(self, other)
      local res = vim.tbl_deep_extend("force", self, other)
      return setmetatable(res, getmetatable(self))
    end
  }
  return setmetatable(props, __mt)
end

return pkg
