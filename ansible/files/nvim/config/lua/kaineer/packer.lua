-- lua/kaineer/packer.lua
--
-- require("kaineer.packer").create_handle()

local types = require("kaineer.types")
local M = {}

local packer_path = "/site/pack/packer/"

--
-- http://neovimcraft.com/plugin/wbthomason/packer.nvim/index.html#bootstrapping
--
function M.ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. packer_path
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

function M.create_handle(use)
  local handle = function(path)
    local obj = require(path)

    if types.table(obj) then
      use(obj)
    elseif types.fn(obj) then
      obj(use)
    elseif types.string(obj) then
      use(obj)
    end
  end

  return handle
end

return M
