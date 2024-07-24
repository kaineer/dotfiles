-- lua/kaineer/cmd.lua

return {
  buildMkcmd = function(message)
    return function(name) -- mkcmd()
      local runcmd = function()
        vim.api.nvim_command(":" .. name)
      end
      return function()
        if not pcall(runcmd) then
          print(message)
        end
      end
    end
  end,
}
