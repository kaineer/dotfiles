-- autocmd/terminal.lua

return {
	name = "Terminal",
	config = function(cmd)
		cmd("TermOpen", {
			pattern = "*",
			callback = function()
				-- vim.cmd(":startinsert")
				-- vim.cmd(":setlocal listchars= nonumber norelativenumber")

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local cleaned = {}
        local skip_next = false

        for _, line in ipairs(lines) do
          -- Пропускаем строки, содержащие OSC 1337 или file://
          if line:match("1337;SetUserVar") or line:match("1337;.*SetUserVar") or line:match("^%s*7;file://") then
            skip_next = false
          elseif skip_next and line:match("^%s*$") then
            skip_next = false
          else
            table.insert(cleaned, line)
          end
        end

        if #cleaned ~= #lines then
          vim.api.nvim_buf_set_lines(0, 0, -1, false, cleaned)
        end
      end,
    })
  end,
}
