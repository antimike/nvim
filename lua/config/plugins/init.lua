local utils = require('utils')

return utils.concat(
    require('config.plugins.display'),
    require('config.plugins.external-tools'),
    require('config.plugins.ide'),
    require('config.plugins.misc'),
    require('config.plugins.navigation'),
    require('config.plugins.text-tools')
)
