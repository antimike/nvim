local found, wk = pcall(require, "which-key")
if found then
  return require("utils.map.which-key")
else
  return require("utils.map.nvim-api")
end
