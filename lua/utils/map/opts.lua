--- Functions to manipulate options for vim mapping API, which-key config, and the convenience functions in other modules of utils.map

local pkg = {}

local default_vim_opts = {
  nowait = false,
  silent = true,
  unique = true,
  script = false,
  expr = false,
  noremap = true,
}

local default_wk_opts  = {
  mode = "n", -- Normal mode
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

-- @param opts Generic mapping options
-- @return vim_opts, buf
function pkg.get_vim_opts(opts)
  error("Not implemented")
end

-- @param opts Generic mapping options
-- @return wk_opts, buf
function pkg.get_wk_opts(opts)
  error("Not implemented")
end

return pkg
