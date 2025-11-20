-- NOTE: Определение длины через vim.fn.strchars()

local M = {}

local ascii_mode = "ascii"
local hiragana_mode = "hira"

M.default_config = {
  dictionary_path = "~/.config/nvim/SKK-JISYO.L.utf-8",
  toggle_key = "<M-;>",
  henkan_key = "/",
  henkan_marker = "▽",
  filetypes = { "markdown" },
  auto_create_keymaps = true,
  allow_henkan_cancel = false,
}

M.config = M.default_config

M.mode = ascii_mode
M.dictionary = {}
M.henkan_active = false
M.kana_buffer = ""
M.henkan_buffer = ""
M.attached_buffers = {}
M.henkan_index = 0

function M.attach_to_buffer(bufnr)
  if M.attached_buffers[bufnr] then
    return
  end

  M.attached_buffers[bufnr] = true

  local buf_opts = { buffer = bufnr }

  M._set_keymaps(buf_opts)

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    buffer = bufnr,
    callback = function()
      if M.mode ~= ascii_mode then
        M.mode = ascii_mode
        vim.notify("SKK: Auto-switched to ASCII mode")
      end
      if M.henkan_active then
        M.cancel_henkan()
      end
    end,
  })
end

-- TODO: добавить биндинг на <CR>
function M.handle_enter(key)
  if M.mode == ascii_mode then
    return "<CR>"
  elseif M.mode == hiragana_mode then
    if M.henkan_active then
      vim.notify("DEBUG: handle_enter in henkan")
      if M.henkan_index > 0 and #M.henkan_candidates >= M.henkan_index then
        vim.notify("DEBUG: trying to select candidate")

        local candidate = M.henkan_candidates[M.henkan_index]

        M.henkan_index = 0

        return M.cancel_henkan(true) .. candidate
      else
        vim.notify("DEBUG: handle_enter in kana")
        M.kana_buffer = ""
        return "<CR>"
      end
    else
      return "<CR>"
    end
  end
end

function M.handle_hiragana_backspace()
  if M.mode == "hira" and M.kana_buffer ~= "" then
    M.kana_buffer = M.kana_buffer:sub(1, -2)
  end
  return "<BS>"
end

function M._set_keymaps(buf_opts)
  -- toggle mode on
  vim.keymap.set(
    "i",
    M.config.toggle_key,
    M.toggle_mode,
    vim.tbl_extend("force", buf_opts, {
      desc = "Toggle SKK mode",
    })
  )

  vim.keymap.set(
    "i",
    M.config.henkan_key,
    M.toggle_henkan,
    vim.tbl_extend("force", buf_opts, {
      expr = true,
      desc = "Start henkan",
    })
  )

  vim.keymap.set(
    "i",
    "<BS>",
    function()
      if M.mode == hiragana_mode then
        if M.henkan_active then
          return M.handle_henkan_backspace()
        else
          return M.handle_hiragana_backspace()
        end
      else
        return "<BS>"
      end
    end,
    vim.tbl_extend("force", buf_opts, {
      expr = true,
      desc = "SKK backspace",
    })
  )

  vim.keymap.set(
    "i",
    "<CR>",
    M.handle_enter,
    vim.tbl_extend("force", buf_opts, {
      expr = true,
      desc = "SKK select",
    })
  )

  if M.config.auto_create_keymaps then
    M.create_kana_mappings(buf_opts)
  end
end

M.clear_buffer = function()
  M.kana_buffer = ""
  M.henkan_buffer = ""
end

M.clear_henkan_buffer = function()
  M.henkan_buffer = ""
end

-- Основная таблица преобразования
M.kana_table = {
  a = "あ",
  i = "い",
  u = "う",
  e = "え",
  o = "お",
  ka = "か",
  ki = "き",
  ku = "く",
  ke = "け",
  ko = "こ",
  sa = "さ",
  shi = "し",
  su = "す",
  se = "せ",
  so = "そ",
  ta = "た",
  chi = "ち",
  tsu = "つ",
  te = "て",
  to = "と",
  na = "な",
  ni = "に",
  nu = "ぬ",
  ne = "ね",
  no = "の",
  ha = "は",
  hi = "ひ",
  fu = "ふ",
  he = "へ",
  ho = "ほ",
  ma = "ま",
  mi = "み",
  mu = "む",
  me = "め",
  mo = "も",
  ya = "や",
  yu = "ゆ",
  yo = "よ",
  _ya = "ゃ",
  _yu = "ゅ",
  _yo = "ょ",
  ra = "ら",
  ri = "り",
  ru = "る",
  re = "れ",
  ro = "ろ",
  wa = "わ",
  wo = "を",
  nn = "ん",
  ga = "が",
  gi = "ぎ",
  gu = "ぐ",
  ge = "げ",
  go = "ご",
  za = "ざ",
  ji = "じ",
  zu = "ず",
  ze = "ぜ",
  zo = "ぞ",
  da = "だ",
  de = "で",
  ["do"] = "ど",
  ba = "ば",
  bi = "び",
  bu = "ぶ",
  be = "べ",
  bo = "ぼ",
  pa = "ぱ",
  pi = "ぴ",
  pu = "ぷ",
  pe = "ぺ",
  po = "ぽ",
  ["."] = "。",
  [","] = "、",
}

function M.create_kana_mappings(buf_opts)
  local skk_keys = {
    -- Гласные
    "a",
    "i",
    "u",
    "e",
    "o",
    "n",
    -- Согласные для слогов
    "c",
    "f",
    "j",
    "k",
    "s",
    "t",
    "n",
    "h",
    "m",
    "y",
    "r",
    "w",
    "g",
    "z",
    "d",
    "b",
    "p",
    -- Пунктуация
    ".",
    ",",
    -- Пробел для активации хенкан
    " ",
  }

  for _, key in ipairs(skk_keys) do
    vim.keymap.set("i", key, function()
      if M.mode == hiragana_mode then
        if M.henkan_active then
          return M.handle_henkan_input(key)
        else
          return M.handle_hiragana_input(key)
        end
      else
        return key
      end
    end, vim.tbl_extend("force", buf_opts, { expr = true }))
  end
end

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", M.default_config, user_config or {})
  M.load_dictionary(vim.fn.expand(M.config.dictionary_path))

  vim.api.nvim_create_autocmd("FileType", {
    pattern = M.config.filetypes,
    callback = function(args)
      M.attach_to_buffer(args.buf)
    end,
  })

  vim.api.nvim_create_user_command("SkkAttach", function()
    M.attach_to_buffer(0)
  end, { desc = "SKK: manual attach" })

  vim.notify("SKK: Plugin loaded")
end

function M.handle_hiragana_input(char)
  -- Временный буфер для теста
  local temp_buffer = M.kana_buffer .. char
  -- vim.notify(
  -- 	"DEBUG handle_hiragana_input: char='"
  -- 		.. char
  -- 		.. "', kana_buffer='"
  -- 		.. M.kana_buffer
  -- 		.. "', temp_buffer='"
  -- 		.. temp_buffer
  -- 		.. "'"
  -- )

  -- Пробуем сконвертировать временный буфер
  local kana = M.romaji_to_hiragana(temp_buffer)

  -- vim.notify("DEBUG kana=" .. kana)

  if kana ~= temp_buffer then
    -- Успешная конвертация - заменяем ВЕСЬ буфер
    local backspaces = string.rep("<BS>", #M.kana_buffer)
    M.clear_buffer()
    return backspaces .. kana
  else
    -- Не конвертируется оставляем буфер
    M.kana_buffer = temp_buffer
    return char
  end
end

function M.romaji_to_hiragana(romaji)
  -- Пробуем разные паттерны
  local patterns = {
    -- Удвоение согласных
    {
      "^([kgstdnhbpmr])(%1)([aiueo])$",
      function(_, v, e)
        return "っ" .. M.kana_table[v .. e]
      end,
    },
    {
      "^t(tsu)$",
      function(c)
        return "っ" .. M.kana_table[c]
      end,
    },
    {
      "^([ct])(ch)([iauo])$",
      function(_, v, e)
        if e == "i" then
          return "っ" .. M.kana_table["chi"]
        else
          return "っ" .. M.kana_table["chi"] .. M.kana_table["_y" .. e]
        end
      end,
    },
    {},
    -- Комбинации с y
    {
      "^([kgsztdnhbpmr])(y)([auo])$",
      function(c, _, v)
        return M.kana_table[c .. "i"] .. M.kana_table["_y" .. v]
      end,
    },
    -- Ши/чи/цзу
    {
      "^sh([auo])$",
      function(v)
        return M.kana_table["shi"] .. M.kana_table["_y" .. v]
      end,
    },
    {
      "^ssh([iauo])$",
      function(c)
        if c == "i" then
          return "っ" .. M.kana_table["shi"]
        else
          return "っ" .. M.kana_table["shi"] .. M.kana_table["_y" .. c]
        end
      end,
    },
    {
      "^ch([auo])$",
      function(v)
        return M.kana_table["chi"] .. M.kana_table["_y" .. v]
      end,
    },
    -- Обычные слоги
    {
      "^([kgsztdnhbpmr])([aiueo])$",
      function(c, v)
        return M.kana_table[c .. v]
      end,
    },
    -- Одиночные
    {
      "^([aiueo])$",
      function(v)
        return M.kana_table[v]
      end,
    },
  }

  for _, pattern in ipairs(patterns) do
    local match = { string.match(romaji, pattern[1]) }
    if #match > 0 then
      vim.notify("DEBUG pattern = " .. pattern[1] .. " on " .. romaji .. ", matches -> " .. vim.inspect(match))
      local result = pattern[2](unpack(match))
      if result then
        return result
      end
    end
  end

  -- Сначала проверяем точное совпадение
  if M.kana_table[romaji] then
    return M.kana_table[romaji]
  end

  vim.notify("DEBUG no match for romaji " .. romaji)

  return romaji -- Не нашли совпадение
end

function M.toggle_mode()
  M.clear_buffer()

  if M.mode == ascii_mode then
    M.mode = hiragana_mode
    vim.notify("SKK: かな mode")
  else
    M.mode = ascii_mode
    vim.notify("SKK: ASCII mode")
  end
end

function M.cancel_henkan(remove_kana)
  M.henkan_active = false
  local kana = M.henkan_buffer
  local romaji = M.kana_buffer
  local nagakuro = "・"
  M.henkan_buffer = ""
  M.kana_buffer = ""
  M.henkan_candidates = {}
  M.henkan_index = 0

  local len = vim.fn.strchars(M.config.henkan_marker .. kana .. romaji)

  if vim.api.nvim_get_mode().mode == "i" then
    vim.notify("SKK: cancelling henkan in insert mode")
    local backspaces = string.rep("<BS>", len)

    if #kana == 0 and #romaji == 0 then
      vim.notify("SKK: empty input, insert nagakuro")
      return backspaces .. nagakuro
    else
      if remove_kana then
        return backspaces
      else
        return backspaces .. kana .. romaji
      end
    end
  else
    vim.notify("SKK: cancelling henkan in normal mode")
    local len = vim.fn.strchars(M.config.henkan_marker .. kana .. romaji)
    local left = string.rep("h", len)
    local rm = string.rep("x", len)
    -- NOTE: выглядит, как смертный грех, которым по большому счету является
    -- но работает
    --
    -- NOTE: посмотреть, почему затирается инпут ПОСЛЕ
    vim.notify("SKK: move " .. left .. "[" .. M.config.henkan_marker .. kana .. romaji .. "]")
    vim.notify("SKK: remove " .. rm .. "[" .. M.config.henkan_marker .. kana .. romaji .. "]")
    vim.api.nvim_input(
      left .. rm .. "i" .. kana .. romaji .. vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    )
  end
end

function M.toggle_henkan()
  if M.mode == hiragana_mode then
    if M.henkan_active then
      return M.cancel_henkan()
    else
      M.henkan_active = true
      M.kana_buffer = ""
      M.henkan_buffer = ""
      vim.notify("SKK: Henkan mode - type word then Space")
      return M.config.henkan_marker
    end
  end

  if M.mode == ascii_mode then
    if M.config.henkan_key == "/" then
      return "/"
    end
  end
end

-- Заглушки для остальных функций
function M.handle_henkan_input(char)
  if char == " " then
    M.handle_henkan_space()
  else
    local temp_buffer = M.kana_buffer .. char
    local kana = M.romaji_to_hiragana(temp_buffer)

    if kana ~= temp_buffer then
      local backspaces = string.rep("<BS>", #M.kana_buffer)
      M.kana_buffer = ""
      M.henkan_buffer = M.henkan_buffer .. kana
      return backspaces .. kana
    else
      M.kana_buffer = temp_buffer
      return char
    end
  end
end

function M.handle_henkan_backspace()
  if #M.henkan_buffer > 0 then
    M.henkan_buffer = M.henkan_buffer:sub(1, -2)
    return "<BS>"
  else
    if M.config.allow_henkan_cancel then
      M.henkan_active = false
      return string.rep("<BS>", #M.config.henkan_marker)
    else
      vim.notify("SKK: Use " .. M.config.henkan_key .. " to cancel henkan")
      return ""
    end
  end
end

function M.handle_henkan_space()
  if M.henkan_index == 0 then
    -- Первый пробел - ищем кандидатов
    M.henkan_candidates = M.find_candidates(M.henkan_buffer)
    if #M.henkan_candidates > 0 then
      M.henkan_index = 1
      return M.show_current_candidate()
    else
      return M.cancel_henkan()
    end
  else
    -- Следующие пробелы - перебираем кандидатов
    M.henkan_index = (M.henkan_index % #M.henkan_candidates) + 1
    return M.show_current_candidate()
  end
end

function M.show_current_candidate()
  if M.henkan_index > 0 and M.henkan_candidates[M.henkan_index] then
    local candidate = M.henkan_candidates[M.henkan_index]
    -- Показываем кандидата (пока через notify, потом можно через float window)
    vim.notify(string.format("SKK: [%d/%d] %s", M.henkan_index, #M.henkan_candidates, candidate))
    return "" -- не вставляем ничего в текст
  end
  return ""
end

function M.find_candidates(kana)
  if M.dictionary[kana] then
    return M.dictionary[kana]
  end
  return {}
end

function M.load_dictionary(path)
  M.dictionary = {}

  local file = io.open(path, "r")
  if not file then
    vim.notify("SKK: Cannot open dictionary: " .. path, vim.log.levels.ERROR)
    return
  end

  for line in file:lines() do
    if not line:match("^;") and line ~= "" then
      local key, values = line:match("^([^%s/]+)%s+/(.+)/")
      if key and values then
        local clean_values = {}
        -- РАЗБИВАЕМ ПО СЛЭШАМ внутри values
        for value in values:gmatch("([^/]+)") do -- ← ИЗМЕНИТЬ РЕГЕКС
          clean_values[#clean_values + 1] = value:gsub(";.*$", ""):gsub("%s+$", "")
        end
        M.dictionary[key] = clean_values
      end
    end
  end

  file:close()
  vim.notify("SKK: Dictionary loaded with " .. #vim.tbl_keys(M.dictionary) .. " entries")
end

return M
