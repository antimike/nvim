local pkg = {}
local ts = require("telescope")
local ts_builtin = require("telescope.builtin")

function pkg.websearch()
  ts.extensions.arecibo.websearch()
end

function pkg.symbols()
  ts_builtin.symbols {
    sources = {
      "emoji",
      "kaomoji",
      "gitmoji",
      "math",
      "latex",
    }
  }
end

return pkg
