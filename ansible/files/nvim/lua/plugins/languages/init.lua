--

return function(use)
  use(require('plugins.languages.markdown'))
  use(require('plugins.languages.json'))
  use(require('plugins.languages.hurl'))

  require('plugins.languages.rofi')()
end
