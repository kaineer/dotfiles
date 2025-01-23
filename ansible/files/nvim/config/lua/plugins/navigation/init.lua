-- plugins/navigation/

local requireAll = require('core.utils').requireWithPrefix

return requireAll('plugins.navigation.', {
  'dirvish', 'tmux',
  'which-key',
  'web-icons',
  'projectionist',
})
