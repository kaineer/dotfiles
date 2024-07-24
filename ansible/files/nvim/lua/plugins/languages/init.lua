--

return function(use)
  use(require('plugins.languages.markdown'))
  use(require('plugins.languages.json'))

  require('plugins.languages.rofi')()
end
