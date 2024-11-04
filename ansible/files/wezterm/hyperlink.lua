-- hyperlink.lua

return function(config, wezterm)
  local rules = wezterm.default_hyperlink_rules()
  local custom_rules = {
    { -- xn:javp+mom
      regex = 'xn:([\\w\\+]+)',
      format = 'https://xnxx.com/search/hd-only/$1',
      highlight = 0,
    },
    { -- gh:kaineer/nhee.ru
      regex = 'gh:([-\\w]+/[-.\\w]+)',
      format = 'https://github.com/$1',
      highlight = 0,
    }
  }

  for _, rule in ipairs(custom_rules) do
    table.insert(rules, rule)
  end

  config.hyperlink_rules = rules
end
