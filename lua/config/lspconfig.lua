local lspconfig = require("lspconfig")
local servers = {
  'pyright',
  'clangd',
  'cmake',
  'gopls',
  'hls',
  'jsonls',
  'rust_analyzer',
  'solargraph',
  'sqlls',
  'taplo',
  'yamlls',
  'zeta_note',
  'html',
  'bashls',
}

for _, s in ipairs(servers) do
  lspconfig[s].setup{}
end
