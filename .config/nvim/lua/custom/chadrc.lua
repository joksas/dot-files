---@type ChadrcConfig 
local M = {}
M.ui = {
  theme = 'tomorrow_night',
  transparency = true,
}
M.plugins = 'custom.plugins'
M.mappings = require('custom.mappings')
return M
