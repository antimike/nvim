-- From https://alpha2phi.medium.com/neovim-plugins-for-a-better-coding-experience-part-3-d4c2df085677
local M = {}
function M.setup()
  require("neogit").setup { integrations = { diffview = true } }
end
return M
