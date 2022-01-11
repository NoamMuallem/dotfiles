local config = require('cosmic.config')
local utils = require('cosmic.utils')

require('neogit').setup(utils.merge({
    kind = "split",
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
  integrations = { diffview = true },

}, config.neogit or {}))
