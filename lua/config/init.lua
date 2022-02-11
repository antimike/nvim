local loaded, plugins = pcall(require('config.plugins'))
if loaded then
    require('config.theme')
    require('config.keymaps')
    require('config.sensible')
    return plugins
end
