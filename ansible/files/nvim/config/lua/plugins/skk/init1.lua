local M = {}

M.mode = "ascii" -- 'hira', 'kata', 'halfkata', 'ascii'
M.dictionary = {}
M.henkan_active = false
M.current_input = ""
M.candidates = {}
M.candidate_index = 1

-- Таблицы преобразования ромадзи → хирагана
M.kana_table = {
	-- Базовые слоги
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
	ra = "ら",
	ri = "り",
	ru = "る",
	re = "れ",
	ro = "ろ",
	wa = "わ",
	wo = "を",
	n = "ん",

	-- Дополнения
	kya = "きゃ",
	kyu = "きゅ",
	kyo = "きょ",
	sha = "しゃ",
	shu = "しゅ",
	sho = "しょ",
	cha = "ちゃ",
	chu = "ちゅ",
	cho = "ちょ",
	nya = "にゃ",
	nyu = "にゅ",
	nyo = "にょ",
	hya = "ひゃ",
	hyu = "ひゅ",
	hyo = "ひょ",
	mya = "みゃ",
	myu = "みゅ",
	myo = "みょ",
	rya = "りゃ",
	ryu = "りゅ",
	ryo = "りょ",
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
	di = "ぢ",
	du = "づ",
	de = "で", -- do = 'ど',
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
}

M.kana_table["do"] = "ど"
-- ну не получается сделать такой ключ

function M.romaji_to_hiragana(romaji)
	-- Сначала проверяем длинные комбинации, потом короткие
	local patterns = {
		-- Долгие комбинации (3 символа)
		{
			"^([kgsztdnhbpmryl])(ya|yu|yo)$",
			function(c, y)
				return M.kana_table[c .. y]
			end,
		},
		{
			"^([kgsztdnhbpmr])(y)(a|u|o)$",
			function(c, _, v)
				return M.kana_table[c .. "y" .. v]
			end,
		},

		-- Обычные слоги (2 символа)
		{
			"^([kgsztdnhbpmr])([aiueo])$",
			function(c, v)
				return M.kana_table[c .. v]
			end,
		},
		{
			"^sh([aiueo])$",
			function(v)
				return M.kana_table["sh" .. v]
			end,
		},
		{
			"^ch([aiueo])$",
			function(v)
				return M.kana_table["ch" .. v]
			end,
		},
		{
			"^ts([aiueo])$",
			function(v)
				return M.kana_table["ts" .. v]
			end,
		},
		{
			"^f([aiueo])$",
			function(v)
				return M.kana_table["f" .. v]
			end,
		},
		{
			"^j([aiueo])$",
			function(v)
				return M.kana_table["j" .. v]
			end,
		},

		-- Одиночные гласные
		{
			"^([aiueon])$",
			function(v)
				return M.kana_table[v]
			end,
		},
	}

	for _, pattern in ipairs(patterns) do
		local match = { string.match(romaji, pattern[1]) }
		if #match > 0 then
			return pattern[2](unpack(match))
		end
	end

	return romaji -- Не нашли совпадение
end

function M.load_dictionary(path)
	M.dictionary = {}

	local file = io.open(path, "r")
	if not file then
		vim.notify("SKK: Cannot open dictionary: " .. path, vim.log.levels.ERROR)
		return
	end

	for line in file:lines() do
		-- Пропускаем комментарии и пустые строки
		if not line:match("^;") and line ~= "" then
			local key, values = line:match("^([^%s/]+)%s+/(.+)/")
			if key and values then
				-- Убираем комментарии в значениях
				local clean_values = {}
				for value in values:gmatch("([^;]+)") do
					-- table.insert(clean_values, value:gsub("%s+$", ""))
					clean_values[#clean_values + 1] = value:gsub("%s+$", "")
				end
				M.dictionary[key] = clean_values
			end
		end
	end

	file:close()
	vim.notify("SKK: Dictionary loaded with " .. #vim.tbl_keys(M.dictionary) .. " entries")
end

function M.find_candidates(kana)
	-- Прямой поиск
	if M.dictionary[kana] then
		return M.dictionary[kana]
	end

	-- Поиск с вариантами (можно расширить)
	return {}
end

function M.handle_input()
	if M.mode == "ascii" then
		return
	end

	local line = vim.fn.getline(".")
	local col = vim.fn.col(".")

	if M.henkan_active then
		-- Режим преобразования
		M.handle_henkan_input(line, col)
	else
		-- Обычный ввод
		M.handle_normal_input(line, col)
	end
end

function M.start_henkan()
	-- M.henkan_active = true
	-- M.current_input = ""
	-- M.candidates = {}
	-- M.candidate_index = 1
	-- vim.notify("SKK: Henkan mode activated")
	if M.mode == "ascii" then
		vim.notify("SKK: switch to Hiragana mode first")
		return
	end

	M.henkan_active = true
	M.current_input = ""
	M.candidates = {}
	M.candidate_index = 1
	vim.notify("SKK: Henkan mode activated - type word then press space")

	return ""
end

-- function M.handle_normal_input(line, col)
-- 	-- Получаем последний введенный символ
-- 	local char = vim.v.char
-- 	if not char or char == "" then
-- 		return
-- 	end
--
-- 	if M.mode == "hira" then
-- 		-- Буферизуем ввод для конвертации ромадзи
-- 		M.current_input = M.current_input .. char
--
-- 		-- Пробуем конвертировать
-- 		local kana = M.romaji_to_hiragana(M.current_input)
-- 		if kana ~= M.current_input then
-- 			-- Успешно сконвертировали - заменяем ввод
-- 			vim.api.nvim_input("<BS>" .. #M.current_input) -- удаляем ромадзи
-- 			vim.api.nvim_input(kana) -- вставляем кану
-- 			M.current_input = "" -- сбрасываем буфер
-- 		else
-- 			-- Не смогли сконвертировать - оставляем как есть
-- 			-- Можно добавить логику для сброса буфера при пробеле и т.д.
-- 			if char:match("%s") then -- пробел или enter
-- 				M.current_input = ""
-- 			end
-- 		end
-- 	end
-- end

function M.handle_normal_input()
	if M.mode == "ascii" then
		vim.notify("DEBUG: ASCII mode, skipping")
		return
	end

	-- Получаем текущую строку и позицию
	local line = vim.fn.getline(".")
	local col = vim.fn.col(".") - 1 -- переводим в 0-based индекс

	vim.notify("DEBUG: mode=" .. M.mode .. ", col=" .. col .. ", line='" .. line .. "'")

	-- Простая логика: конвертируем последний символ
	if col > 0 then
		local last_char = line:sub(col, col)
		vim.notify("DEBUG: last_char='" .. last_char .. "'")

		-- Простая таблица для теста
		local simple_table = {
			a = "あ",
			i = "い",
			u = "う",
			e = "え",
			o = "お",
			k = "か",
			s = "さ",
			t = "た",
			n = "な",
			h = "は",
		}

		if simple_table[last_char] then
			vim.notify("DEBUG: Converting '" .. last_char .. "' to '" .. simple_table[last_char] .. "'")
			-- Заменяем символ
			local new_line = line:sub(1, col - 1) .. simple_table[last_char] .. line:sub(col + 1)
			vim.fn.setline(".", new_line)
		end
	end
end

function M.toggle_mode()
	if M.mode == "ascii" then
		M.mode = "hira"
		vim.notify("SKK: Hiragana mode")
	else
		M.mode = "ascii"
		vim.notify("SKK: ASCII mode")
	end

	-- Отладочная информация
	vim.notify("DEBUG: Current mode = " .. M.mode)
end

function M.handle_henkan_input(line, col)
	local char = vim.v.char

	if char == " " then -- Пробел - перебор кандидатов
		if #M.candidates == 0 then
			-- Первое нажатие пробела - ищем кандидатов для текущего ввода
			M.candidates = M.find_candidates(M.current_input)
			if #M.candidates > 0 then
				M.candidate_index = 1
				M.show_candidates()
			else
				vim.notify("SKK: No candidates found for: " .. M.current_input)
				M.cancel_henkan()
			end
		else
			-- Следующие нажатия - перебираем кандидатов
			M.candidate_index = (M.candidate_index % #M.candidates) + 1
			M.show_candidates()
		end
	elseif char == "\r" or char == "\n" then -- Enter - подтверждение
		M.confirm_henkan()
	elseif char == "\x07" or char == "\x1b" then -- Ctrl+G или Escape - отмена
		M.cancel_henkan()
	else
		-- Обычный ввод - добавляем к текущему вводу
		M.current_input = M.current_input .. char
	end
end

function M.show_candidates()
	if #M.candidates > 0 then
		local current = M.candidates[M.candidate_index]
		vim.notify(string.format("SKK: [%d/%d] %s", M.candidate_index, #M.candidates, current))
		-- Здесь можно добавить отображение в float window или statusline
	end
end

function M.confirm_henkan()
	if #M.candidates > 0 then
		local selected = M.candidates[M.candidate_index]
		-- Заменяем текущий ввод выбранным кандидатом
		vim.api.nvim_input("<BS>" .. #M.current_input) -- удаляем кану
		vim.api.nvim_input(selected) -- вставляем кандзи
	end
	M.cancel_henkan()
end

function M.cancel_henkan()
	M.henkan_active = false
	M.current_input = ""
	M.candidates = {}
	M.candidate_index = 1
	vim.notify("SKK: Henkan cancelled")
end

function M.setup()
	-- Загрузка словаря
	M.load_dictionary(vim.fn.expand("~/.config/nvim/SKK-JISYO.L.utf-8"))

	-- Клавиши
	vim.keymap.set("i", "<M-j>", M.toggle_mode, { desc = "Toggle SKK mode" })
	vim.keymap.set("i", "/", M.start_henkan, { desc = "Start henkan" })

	-- Автообработка ввода (упрощенно)
	vim.cmd([[
    augroup SKKInput
      autocmd!
      autocmd InsertCharPre * lua require('plugins.skk').handle_input()
    augroup END
  ]])
end

return M
