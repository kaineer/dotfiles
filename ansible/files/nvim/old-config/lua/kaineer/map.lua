-- lua/kaineer/map.lua

local types = require("kaineer.types")
local merge = require("kaineer.fn").merge

local map = {}

local set_keymap = vim.api.nvim_set_keymap
local set_buf_keymap = vim.api.nvim_buf_set_keymap

local normal = 'n'
local insert = 'i'
local terminal = 't'
local visual = 'v'

-- singleMapping({ "K", ":Action<cr>" }, { silent = true })
local singleMapping = function(tbl, options)
  if not types.table(tbl) then
    return
  end
  local opts = {
    silent  = options.silent,
    expr    = options.expr,
    noremap = true,
  }

  local mode = options.mode or normal
  local lhs = tbl[1]
  local rhs = tbl[2]

  if types.fn(rhs) then
    local cbopts = merge(opts, {
      callback = rhs
    })
    set_keymap(mode, lhs, '', cbopts)
  elseif types.string(rhs) then
    set_keymap(mode, lhs, rhs, opts)
  end
end

-- commonMapping({
--   { 'K', ':Action<cr>' },
--   opts = { mode = 'i', silent = true }
-- })
local commonMapping = function(tbl, mappings)
  local options = tbl.opts or { mode = 'n' }
  if not types.table(mappings) then
    mappings = tbl
  end
  if not types.table(mappings) then
    return
  end
  for _, mapping in ipairs(mappings) do
    singleMapping(mapping, options)
  end
end

function map.mode(tbl, mode)
  local opts = tbl.opts or {}
  opts.mode = mode
  opts.silent = true
  tbl.opts = opts

  commonMapping(tbl)
end

-- map.normal({
--   { 'K', ':Action1<cr>' },
--   { 'L', ':Action2<cr>' },
-- })
function map.normal(tbl)
  map.mode(tbl, normal)
end

function map.insert(tbl)
  map.mode(tbl, insert)
end

function map.terminal(tbl)
  map.mode(tbl, terminal)
end

function map.visual(tbl)
  map.mode(tbl, visual)
end

function map.buffer(tbl, opts)
  local mode = normal

  if not types.table(opts) then
    opts = {}
  end
  if not types.boolean(opts.noremap) then
    opts.noremap = true
  end
  if not types.boolean(opts.silent) then
    opts.silent = true
  end

  for _, mapping in ipairs(tbl) do
    local lhs = mapping[1]
    local rhs = mapping[2]

    set_buf_keymap(0, mode, lhs, rhs, opts)
  end
end

return map
