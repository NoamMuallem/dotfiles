local config = require('cosmic.config')
local utils = require('cosmic.utils')

require('diffview').setup(utils.merge({
}, config.diffview or {}))
