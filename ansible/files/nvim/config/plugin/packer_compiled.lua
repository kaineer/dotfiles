-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/kaineer/.cache/nvim/packer_hererocks/2.1.1713484068/share/lua/5.1/?.lua;/home/kaineer/.cache/nvim/packer_hererocks/2.1.1713484068/share/lua/5.1/?/init.lua;/home/kaineer/.cache/nvim/packer_hererocks/2.1.1713484068/lib/luarocks/rocks-5.1/?.lua;/home/kaineer/.cache/nvim/packer_hererocks/2.1.1713484068/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/kaineer/.cache/nvim/packer_hererocks/2.1.1713484068/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["boringcomment.nvim"] = {
    config = { "\27LJ\2\n2\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\29comment_visual_selection.\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\25comment_current_line‹\1\1\0\6\0\n\0\0196\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\6\0003\5\a\0B\1\4\0016\1\2\0009\1\3\0019\1\4\1'\3\b\0'\4\6\0003\5\t\0B\1\4\0012\0\0€K\0\1\0\0\6n\0\agc\6x\bset\vkeymap\bvim\28boringcomment.commenter\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/boringcomment.nvim",
    url = "https://github.com/alexshelto/boringcomment.nvim"
  },
  ["calendar-vim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/calendar-vim",
    url = "https://github.com/renerocksai/calendar-vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tmux"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/cmp-tmux",
    url = "https://github.com/andersevenrud/cmp-tmux"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["eyeliner.nvim"] = {
    config = { "\27LJ\2\ng\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\bdim\2\21highlight_on_key\2\nmatch\17[A-Za-z0-9.]\nsetup\reyeliner\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/eyeliner.nvim",
    url = "https://github.com/jinh0/eyeliner.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fugitive-gitlab.vim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/fugitive-gitlab.vim",
    url = "https://github.com/shumphrey/fugitive-gitlab.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/opt/git-messenger.vim",
    url = "https://github.com/rhysd/git-messenger.vim"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/gv.vim",
    url = "https://github.com/junegunn/gv.vim"
  },
  ["hurl.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\thurl\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/hurl.nvim",
    url = "https://github.com/jellydn/hurl.nvim"
  },
  ["kulala.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vkulala\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/kulala.nvim",
    url = "https://github.com/mistweaverco/kulala.nvim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n¥\b\0\0\v\0*\0009'\0\0\0'\1\1\0'\2\2\0'\3\3\0006\4\4\0'\6\5\0B\4\2\0029\4\6\0045\6\21\0005\a\a\0005\b\b\0=\0\t\b=\1\n\b=\b\v\a5\b\f\0=\2\t\b=\3\n\b=\b\r\a5\b\14\0004\t\0\0=\t\15\b4\t\0\0=\t\16\b=\b\17\a4\b\0\0=\b\18\a5\b\19\0=\b\20\a=\a\22\0065\a\24\0005\b\23\0=\b\25\a5\b\26\0=\b\27\a4\b\3\0005\t\28\0005\n\29\0=\n\30\t>\t\1\b=\b\31\a5\b \0=\b!\a5\b\"\0=\b#\a5\b$\0=\b%\a=\a&\0064\a\0\0=\a'\0064\a\0\0=\a\16\0064\a\0\0=\a(\0064\a\0\0=\a)\6B\4\2\1K\0\1\0\15extensions\20inactive_winbar\ftabline\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\fsymbols\1\0\4\funnamed\b[ ]\rreadonly\b[-]\fnewfile\t[Ã—]\rmodified\b[+]\1\2\2\0\rfilename\fsymbols\0\tpath\3\2\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\6\14lualine_a\0\14lualine_y\0\14lualine_z\0\14lualine_x\0\14lualine_c\0\14lualine_b\0\1\2\0\0\tmode\foptions\1\0\6\foptions\0\rsections\0\ftabline\0\15extensions\0\20inactive_winbar\0\vwinbar\0\frefresh\1\0\3\vwinbar\3è\a\ftabline\3è\a\15statusline\3è\a\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\2\vwinbar\0\15statusline\0\23section_separators\1\0\2\tleft\0\nright\0\25component_separators\nright\tleft\1\0\2\tleft\0\nright\0\1\0\t\23disabled_filetypes\0\23section_separators\0\ntheme\tnord\25component_separators\0\18icons_enabled\2\frefresh\0\17globalstatus\2\25always_divide_middle\2\17ignore_focus\0\nsetup\flualine\frequire\bî‚²\bî‚°\bî‚³\bî‚±\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["mkdnflow.nvim"] = {
    config = { "\27LJ\2\nˆ\3\0\0\6\0\18\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0005\4\f\0005\5\v\0>\5\1\4=\4\r\0035\4\15\0005\5\14\0>\5\1\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\rmappings\20MkdnTableFormat\1\3\0\0\0\15<leader>mf\1\2\0\0\6n\14MkdnEnter\1\3\0\0\0\n<c-j>\1\4\0\0\6n\6v\6i\1\0\4\24MkdnDecreaseHeading\1\24MkdnIncreaseHeading\1\20MkdnTableFormat\0\14MkdnEnter\0\14filetypes\1\0\2\amd\2\rmarkdown\2\nlinks\1\0\1\fconceal\2\fmodules\1\0\2\vtables\2\nfolds\2\1\0\5\rmappings\0\14filetypes\0\nlinks\0\fmodules\0\vsilent\2\nsetup\rmkdnflow\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/mkdnflow.nvim",
    url = "https://github.com/jakewvincent/mkdnflow.nvim"
  },
  ["nord.nvim"] = {
    config = { "\27LJ\2\n‰\3\0\0\5\0\16\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\3\0009\1\4\1'\3\5\0B\1\2\1\18\1\0\0006\3\3\0009\3\6\0035\4\a\0B\1\3\0016\1\3\0009\1\4\1'\3\b\0B\1\2\0016\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\3B\1\2\1K\0\1\0\16backgrounds\1\4\0\0\vNormal\vLineNr\15SignColumn\vcolors\1\0\2\16backgrounds\0\vcolors\0\1\0\2\vactive\19 guibg=#2e3440\rinactive\19 guibg=#4b556a\nsetup\30plugins.colorscheme.focus\29:hi Delimiter ctermfg=15\1\0\2\18nord_contrast\1\28nord_disable_background\2\6g\21colorscheme nord\bcmd\bvim\vassign\15kaineer.fn\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nord.nvim",
    url = "https://github.com/shaunsingh/nord.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n@\0\1\5\1\4\0\a6\1\0\0009\1\1\1-\3\0\0005\4\2\0=\0\3\4B\1\3\1K\0\1\0\0À\tname\1\0\1\tname\0\vinsert\ntable$\1\1\5\2\1\0\6-\1\0\0-\3\1\0003\4\0\0B\1\3\0012\0\0€K\0\1\0\1\0\0À\0002\3\0\5\2\1\1\b4\0\3\0G\1\0\0?\1\0\0-\1\0\0004\3\0\0003\4\0\0002\0\0€D\1\3\0\5À\4À\0\3€€À™\0047\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\vexpand\fsnippet\bvim\v\0\2\2\0\0\0\1L\1\2\0í\b\1\0\20\0003\0e6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0009\2\4\0026\3\0\0'\5\5\0B\3\2\0029\4\6\0039\5\a\0036\6\0\0'\b\b\0B\6\2\0023\a\t\0009\b\n\0005\n\f\0005\v\v\0=\v\r\n5\v\15\0003\f\14\0=\f\16\v=\v\17\n5\v\19\0009\f\18\1B\f\1\2=\f\20\v9\f\21\1B\f\1\2=\f\22\v9\f\23\1B\f\1\2=\f\24\v9\f\25\1B\f\1\2=\f\26\v9\f\27\0015\14\28\0B\f\2\2=\f\29\v=\v\2\n\18\v\2\0\18\r\a\0'\15\30\0'\16\31\0'\17 \0'\18!\0'\19\"\0B\r\6\2\18\14\a\0'\16 \0B\14\2\0A\v\1\2=\v\4\n5\v'\0009\f#\0065\14$\0003\15%\0=\15&\14B\f\2\2=\f(\v=\v)\nB\b\2\0019\b\n\0009\b*\b5\n+\0005\v-\0009\f\2\0009\f,\f9\f*\fB\f\1\2=\f\2\v\18\f\a\0'\14 \0B\f\2\2=\f\4\vB\b\3\0019\b\n\0009\b*\b'\n.\0005\v/\0009\f,\0019\f*\fB\f\1\2=\f\2\v\18\f\2\0\18\14\a\0'\16!\0B\14\2\2\18\15\a\0'\17*\0B\15\2\0A\f\1\2=\f\4\vB\b\3\0016\b0\0009\b1\b'\n2\0B\b\2\0012\0\0€K\0\1\0Â\1    \" Expand\n    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'\n    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'\n  \bcmd\bvim\1\0\2\fmapping\0\fsources\0\6:\1\0\2\fmapping\0\fsources\0\vpreset\1\3\0\0\6/\6?\fcmdline\15formatting\vformat\1\0\1\vformat\0\vbefore\0\1\0\4\rmaxwidth\0032\14with_text\2\vbefore\0\tmode\16symbol_text\15cmp_format\ttmux\tpath\vbuffer\rsnippets\rnvim_lsp\t<cr>\1\0\1\vselect\2\fconfirm\n<c-.>\rcomplete\n<c-e>\nabort\n<c-p>\21select_prev_item\n<c-n>\1\0\5\n<c-n>\0\n<c-.>\0\n<c-e>\0\n<c-p>\0\t<cr>\0\21select_next_item\fsnippet\vexpand\1\0\1\vexpand\0\0\rmatching\1\0\5\fmapping\0\fsnippet\0\15formatting\0\rmatching\0\fsources\0\1\0\1\28disallow_fuzzy_matching\1\nsetup\0\flspkind\btap\fforEach\15kaineer.fn\fsources\vconfig\fmapping\bcmp\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nm\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15javascript\1\0\1\15javascript\0\1\0\1\tmode\fvirtual\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nY\0\0\3\0\3\0\t6\0\0\0'\2\1\0B\0\2\2B\0\1\0016\0\0\0'\2\2\0B\0\2\2B\0\1\1K\0\1\0\22plugins.lsp.mason\24plugins.lsp.servers\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-snippets"] = {
    config = { "\27LJ\2\nÃ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\23extended_filetypes\15typescript\1\0\1\15typescript\0\1\2\0\0\15javascript\1\0\3\22create_cmp_source\2\23extended_filetypes\0\22friendly_snippets\2\nsetup\rsnippets\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-snippets",
    url = "https://github.com/garymjr/nvim-snippets"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÛ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21ensure_installed\1\f\0\0\tyaml\blua\thttp\bcpp\vpython\truby\trust\tmake\btsx\15javascript\vvimdoc\vindent\1\0\2\21ensure_installed\0\vindent\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\n¹\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\b\tmode\vcursor\vzindex\3\20\15trim_scope\nouter\24multiline_threshold\3\20\17line_numbers\2\22min_window_height\3\0\14max_lines\3\1\venable\2\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telekasten.nvim"] = {
    config = { "\27LJ\2\nà\6\0\0\a\0\24\0-6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0B\1\2\0026\2\0\0'\4\6\0B\2\2\0029\2\a\0025\4\b\0=\1\t\4\18\5\1\0'\6\n\0&\5\6\5=\5\v\4\18\5\1\0'\6\f\0&\5\6\5=\5\r\4\18\5\1\0'\6\14\0&\5\6\5=\5\15\4B\2\2\0019\2\16\0004\4\b\0005\5\17\0>\5\1\0045\5\18\0>\5\2\0045\5\19\0>\5\3\0045\5\20\0>\5\4\0045\5\21\0>\5\5\0045\5\22\0>\5\6\0045\5\23\0>\5\a\4B\2\2\1K\0\1\0\1\3\0\0\14<leader>z\20:Telekasten<cr>\1\3\0\0\15<leader>zt :Telekasten toggle_todo<cr>\1\3\0\0\16<leader>zgt\31:Telekasten goto_today<cr>\1\3\0\0\15<leader>zs!:Telekasten search_notes<cr>\1\3\0\0\15<leader>zn\31:Telekasten find_notes<cr>\1\3\0\0\15<leader>zd%:Telekasten find_daily_notes<cr>\1\3\0\0\15<leader>zw&:Telekasten find_weekly_notes<cr>\vnormal\14templates\15/templates\rweeklies\f/weekly\fdailies\v/daily\thome\1\0\r\31follow_creates_nonexisting\2\26command_palette_theme\bivy\14extension\b.md\14templates\0\rweeklies\0\fdailies\0\22auto_set_filetype\2\22take_over_my_home\2\24rename_update_links\2\thome\0\20show_tags_theme\bivy weeklies_create_nonexisting\2\31dailies_create_nonexisting\2\nsetup\15telekasten\23~/git/notes/kasten\vexpand\afn\bvim\16kaineer.map\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/telekasten.nvim",
    url = "https://github.com/renerocksai/telekasten.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/telescope-github.nvim",
    url = "https://github.com/nvim-telescope/telescope-github.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n\"\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\t<cr>\6:(\0\1\5\1\1\0\5-\1\0\0'\3\0\0\18\4\0\0&\3\4\3D\1\2\0\3À\15Telescope ,\0\1\4\1\1\0\5-\1\0\0009\1\0\1\18\3\0\0B\1\2\1K\0\1\0\1À\19load_extension÷\t\1\0\16\0001\2\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\0\0'\3\3\0B\1\2\0026\2\0\0'\4\4\0B\2\2\0023\3\5\0003\4\6\0005\5\a\0003\6\b\0006\a\0\0'\t\t\0B\a\2\0029\a\n\aB\a\1\2\18\b\0\0\18\n\5\0\18\v\6\0B\b\3\0019\b\v\0015\n\f\0=\a\r\n5\v\18\0005\f\16\0004\r\3\0005\14\14\0>\14\1\r5\14\15\0>\14\2\r=\r\17\f=\f\19\v4\f\3\0006\r\0\0'\15\t\0B\r\2\0029\r\20\r4\15\0\0B\r\2\0?\r\0\0=\f\21\v5\f\22\0=\f\23\v=\v\24\nB\b\2\0019\b\25\0024\n\15\0005\v\26\0\18\f\4\0'\14\27\0B\f\2\0?\f\1\0>\v\1\n5\v\28\0\18\f\4\0'\14\29\0B\f\2\0?\f\1\0>\v\2\n5\v\30\0\18\f\4\0'\14\23\0B\f\2\0?\f\1\0>\v\3\n5\v\31\0\18\f\4\0'\14 \0B\f\2\0?\f\1\0>\v\4\n5\v!\0\18\f\4\0'\14\"\0B\f\2\0?\f\1\0>\v\5\n5\v#\0\18\f\4\0'\14$\0B\f\2\0?\f\1\0>\v\6\n5\v%\0\18\f\4\0'\14&\0B\f\2\0?\f\1\0>\v\a\n5\v'\0\18\f\4\0'\14(\0B\f\2\0?\f\1\0>\v\b\n5\v)\0\18\f\4\0'\14(\0B\f\2\0?\f\1\0>\v\t\n5\v*\0\18\f\4\0'\14+\0B\f\2\0?\f\1\0>\v\n\n5\v,\0\18\f\4\0'\14-\0B\f\2\0?\f\1\0>\v\v\n5\v.\0\18\f\4\0'\14\19\0B\f\2\0?\f\1\0>\v\f\n5\v/\0>\v\r\n5\v0\0>\v\14\nB\b\2\0012\0\0€K\0\1\0\1\3\0\0\16<leader>oup\24:UrlView packer<cr>\1\3\0\0\16<leader>ouu\17:UrlView<cr>\1\2\0\0\15<leader>op\14live_grep\1\2\0\0\15<leader>rg\16diagnostics\1\2\0\0\15<leader>od\1\2\0\0\14<leader>/\30current_buffer_fuzzy_find\1\2\0\0\15<leader>ol\14registers\1\2\0\0\15<leader>or\fkeymaps\1\2\0\0\15<leader>om\14git_files\1\2\0\0\15<leader>og\roldfiles\1\2\0\0\15<leader>oh\1\2\0\0\15<leader>ot\fbuffers\1\2\0\0\15<leader>ob\15find_files\1\2\0\0\15<leader>of\vnormal\15extensions\17file_browser\1\0\2\ntheme\bivy\17hijack_netrw\1\14ui-select\15get_cursor\fproject\1\0\3\17file_browser\0\14ui-select\0\fproject\0\14base_dirs\1\0\2\ntheme\bivy\14base_dirs\0\1\0\2\14max_depth\3\3\tpath$/home/kaineer/devel/htmlacademy\1\0\2\14max_depth\3\3\tpath\22/home/kaineer/git\rdefaults\1\0\2\15extensions\0\rdefaults\0\nsetup\fget_ivy\21telescope.themes\0\1\3\0\0\fproject\14ui-select\0\0\16kaineer.map\14telescope\fforEach\15kaineer.fn\frequire\3€€À™\4\5€€À™\4\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["urlview.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\19default_picker\14telescope\nsetup\furlview\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/urlview.nvim",
    url = "https://github.com/axieax/urlview.nvim"
  },
  ["vim-dirvish"] = {
    config = { "\27LJ\2\nQ\0\0\4\3\4\0\n6\0\0\0009\0\1\0+\1\1\0=\1\2\0-\0\0\0009\0\3\0-\2\1\0-\3\2\0B\0\3\1K\0\1\0\0\0\1\0\2\0\vbuffer\vnumber\14opt_local\bvimY\1\1\6\3\4\0\a\18\1\0\0'\3\0\0005\4\1\0003\5\2\0=\5\3\4B\1\3\1K\0\1\0\1À\3À\2À\rcallback\0\1\0\2\rcallback\0\fpattern\fdirvish\rFileType—\2\1\0\b\0\r\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\0\0'\3\3\0B\1\2\0025\2\4\0004\3\a\0005\4\5\0>\4\1\0035\4\6\0>\4\2\0035\4\a\0>\4\3\0035\4\b\0>\4\4\0035\4\t\0>\4\5\0035\4\n\0>\4\6\3\18\4\0\0'\6\v\0003\a\f\0B\4\3\0012\0\0€K\0\1\0\0\15DirvishNav\1\3\0\0\14<m-enter>\23:!nemo % &<cr><cr>\1\3\0\0\6m\14:!mkdir %\1\3\0\0\6r\f.rm -rf\1\3\0\0\6e\t:e %\1\3\0\0\6l\t<cr>\1\3\0\0\6h\6-\1\0\2\fnoremap\1\vsilent\1\16kaineer.map\aau\20kaineer.autocmd\frequire\0" },
    loaded = true,
    needs_bufread = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/opt/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gist"] = {
    config = { "\27LJ\2\nÅ\2\0\0\b\0\b\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0006\3\3\0009\3\4\0035\4\5\0006\5\0\0'\a\6\0B\5\2\2=\5\a\4B\1\3\1K\0\1\0\15gist_token\24plugins.gist.secret\1\0\a\15gist_token\0\22gist_clip_command\31xclip -selection clipboard\16github_user\fkaineer\27gist_get_multiple_file\3\1\24gist_browser_comand\26brave-browser %URL% &!gist_open_browser_after_post\3\1\23gist_show_privates\3\1\6g\bvim\vassign\15kaineer.fn\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-gist",
    url = "https://github.com/mattn/vim-gist"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-json"] = {
    config = { "\27LJ\2\nY\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0\20set foldlevel=1\26set foldmethod=syntax\bcmd\bvimP\1\1\6\0\4\0\a\18\1\0\0'\3\0\0005\4\1\0003\5\2\0=\5\3\4B\1\3\1K\0\1\0\rcallback\0\1\0\2\rcallback\0\fpattern\tjson\rFileType°\1\1\0\6\0\t\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0003\4\4\0B\1\3\1\18\1\0\0'\3\5\0005\4\a\0005\5\6\0=\5\b\4B\1\3\1K\0\1\0\fpattern\1\0\2\fcommand\16set ft=json\fpattern\0\1\3\0\0\v.swcrc\14.eslintrc\fBufRead\0\16JsonFolding\aau\20kaineer.autocmd\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-json",
    url = "https://github.com/elzr/vim-json"
  },
  ["vim-projectionist"] = {
    config = { "\27LJ\2\nß\2\0\0\t\0\f\0 '\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\1\18\3\0\0B\1\2\0026\2\1\0'\4\4\0B\2\2\0029\2\5\0024\4\4\0005\5\6\0\18\6\1\0'\b\a\0B\6\2\2>\6\2\5>\5\1\0045\5\b\0\18\6\1\0'\b\t\0B\6\2\2>\6\2\5>\5\2\0045\5\n\0\18\6\1\0'\b\v\0B\6\2\2>\6\2\5>\5\3\4B\2\2\1K\0\1\0\aAV\1\2\1\0\b av\tdesc#Projectionist alternate vsplit\aAS\1\2\1\0\b as\tdesc\"Projectionist alternate split\6A\1\2\1\0\b aa\tdesc\28Projectionist alternate\badd\14which-key\15buildMkcmd\16kaineer.cmd\frequire+Could not find projectionist alternate\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-tmux-navigator"] = {
    config = { "\27LJ\2\n!\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\6>\b<m-2\0\2\6\0\2\0\6\18\2\0\0'\3\0\0\18\4\1\0'\5\1\0&\2\5\2L\2\2\0\t<cr>\18:TmuxNavigateþ\1\1\0\23\0\b\1#6\0\0\0'\2\1\0B\0\2\0023\1\2\0003\2\3\0005\3\4\0005\4\5\0006\5\6\0\18\a\3\0B\5\2\4H\b\21€6\n\6\0\18\f\4\0B\n\2\4H\r\15€9\15\a\0004\17\3\0004\18\3\0\18\19\1\0\18\21\r\0B\19\2\2>\19\1\18\18\19\2\0\18\21\t\0\18\22\14\0B\19\3\0?\19\0\0>\18\1\17\18\18\b\0B\15\3\1F\r\3\3R\rï\127F\b\3\3R\bé\127K\0\1\0\tmode\npairs\1\0\5\6l\nRight\6j\tDown\6h\tLeft\6o\rPrevious\6k\aUp\1\0\3\6t\15<c-\\><c-n>\6n\5\6i\n<c-[>\0\0\16kaineer.map\frequire\5€€À™\4\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ",
    url = "https://github.com/hrsh7th/vim-vsnip-integ"
  },
  ["vim-yankstack"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/vim-yankstack",
    url = "https://github.com/maxbrunsfeld/vim-yankstack"
  },
  ["webapi-vim"] = {
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/webapi-vim",
    url = "https://github.com/mattn/webapi-vim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n¦\2\0\0\6\0\17\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0025\3\5\0B\0\3\0016\0\0\0'\2\6\0B\0\2\0029\0\a\0005\2\r\0005\3\v\0004\4\4\0005\5\b\0>\5\1\0045\5\t\0>\5\2\0045\5\n\0>\5\3\4=\4\f\3=\3\14\0025\3\15\0=\3\16\2B\0\2\1K\0\1\0\fplugins\1\0\1\14registers\1\freplace\1\0\2\freplace\0\fplugins\0\bkey\1\0\1\bkey\0\1\3\0\0\n<tab>\bTAB\1\3\0\0\t<cr>\aCR\1\3\0\0\f<space>\bSPC\nsetup\14which-key\1\0\2\15timeoutlen\3 \6\ftimeout\2\6o\bvim\vassign\15kaineer.fn\frequire\0" },
    loaded = true,
    path = "/home/kaineer/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vim-dirvish
time([[Setup for vim-dirvish]], true)
try_loadstring("\27LJ\2\n‹\3\0\0\5\0\b\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\3\0009\1\4\1'\3\5\0B\1\2\1\18\1\0\0006\3\3\0009\3\6\0035\4\a\0B\1\3\1K\0\1\0\1\0\2\17dirvish_mode\28:sort ,^\\v(.*[\\/])|\\ze,\23loaded_netrwPlugin\3\1\6gî\1    command! -nargs=? -complete=dir Explore Dirvish <args>\n    command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>\n    command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>\n  \bcmd\bvim\vassign\15kaineer.fn\frequire\0", "setup", "vim-dirvish")
time([[Setup for vim-dirvish]], false)
time([[packadd for vim-dirvish]], true)
vim.cmd [[packadd vim-dirvish]]
time([[packadd for vim-dirvish]], false)
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n´\1\0\0\5\0\6\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0006\3\3\0009\3\4\0035\4\5\0B\1\3\1K\0\1\0\1\0\3'tmux_navigator_disable_when_zoomed\3\1\"tmux_navigator_save_on_switch\3\1\31tmux_navigator_no_mappings\3\1\6g\bvim\vassign\15kaineer.fn\frequire\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
time([[packadd for vim-tmux-navigator]], true)
vim.cmd [[packadd vim-tmux-navigator]]
time([[packadd for vim-tmux-navigator]], false)
-- Setup for: git-messenger.vim
time([[Setup for git-messenger.vim]], true)
try_loadstring("\27LJ\2\nÚ\4\0\0\b\0\24\00096\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\a\0'\2\b\0B\0\2\0029\0\t\0'\2\n\0B\0\2\0026\1\a\0'\3\v\0B\1\2\0029\1\f\0014\3\5\0005\4\r\0\18\5\0\0'\a\14\0B\5\2\2>\5\2\4>\4\1\0035\4\15\0\18\5\0\0'\a\16\0B\5\2\2>\5\2\4>\4\2\0035\4\17\0\18\5\0\0'\a\18\0B\5\2\2>\5\2\4>\4\3\0035\4\19\0\18\5\0\0'\a\20\0B\5\2\2>\5\2\4>\4\4\3B\1\2\0016\1\a\0'\3\21\0B\1\2\0029\1\22\0014\3\3\0005\4\23\0>\4\1\3B\1\2\1K\0\1\0\1\3\0\0\n<c-o>\17:GBrowse<cr>\vvisual\16kaineer.map\17GitMessenger\1\2\1\0\b gm\tdesc\26Annotate current line\aGV\1\2\1\0\b gl\tdesc\fGit log\14Git add .\1\2\1\0\b ga\tdesc\25Git add current file\6G\1\2\1\0\b gs\tdesc\15Git status\badd\14which-key\bWTF\15buildMkcmd\16kaineer.cmd\frequire\1\0\1\vborder\vsingle$git_messenger_floating_win_opts\25%Y.%m.%d -- %H:%M:%S\30git_messenger_date_format$git_messenger_always_into_popup\6g\bvim\0", "setup", "git-messenger.vim")
time([[Setup for git-messenger.vim]], false)
time([[packadd for git-messenger.vim]], true)
vim.cmd [[packadd git-messenger.vim]]
time([[packadd for git-messenger.vim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n@\0\1\5\1\4\0\a6\1\0\0009\1\1\1-\3\0\0005\4\2\0=\0\3\4B\1\3\1K\0\1\0\0À\tname\1\0\1\tname\0\vinsert\ntable$\1\1\5\2\1\0\6-\1\0\0-\3\1\0003\4\0\0B\1\3\0012\0\0€K\0\1\0\1\0\0À\0002\3\0\5\2\1\1\b4\0\3\0G\1\0\0?\1\0\0-\1\0\0004\3\0\0003\4\0\0002\0\0€D\1\3\0\5À\4À\0\3€€À™\0047\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\vexpand\fsnippet\bvim\v\0\2\2\0\0\0\1L\1\2\0í\b\1\0\20\0003\0e6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0009\2\4\0026\3\0\0'\5\5\0B\3\2\0029\4\6\0039\5\a\0036\6\0\0'\b\b\0B\6\2\0023\a\t\0009\b\n\0005\n\f\0005\v\v\0=\v\r\n5\v\15\0003\f\14\0=\f\16\v=\v\17\n5\v\19\0009\f\18\1B\f\1\2=\f\20\v9\f\21\1B\f\1\2=\f\22\v9\f\23\1B\f\1\2=\f\24\v9\f\25\1B\f\1\2=\f\26\v9\f\27\0015\14\28\0B\f\2\2=\f\29\v=\v\2\n\18\v\2\0\18\r\a\0'\15\30\0'\16\31\0'\17 \0'\18!\0'\19\"\0B\r\6\2\18\14\a\0'\16 \0B\14\2\0A\v\1\2=\v\4\n5\v'\0009\f#\0065\14$\0003\15%\0=\15&\14B\f\2\2=\f(\v=\v)\nB\b\2\0019\b\n\0009\b*\b5\n+\0005\v-\0009\f\2\0009\f,\f9\f*\fB\f\1\2=\f\2\v\18\f\a\0'\14 \0B\f\2\2=\f\4\vB\b\3\0019\b\n\0009\b*\b'\n.\0005\v/\0009\f,\0019\f*\fB\f\1\2=\f\2\v\18\f\2\0\18\14\a\0'\16!\0B\14\2\2\18\15\a\0'\17*\0B\15\2\0A\f\1\2=\f\4\vB\b\3\0016\b0\0009\b1\b'\n2\0B\b\2\0012\0\0€K\0\1\0Â\1    \" Expand\n    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'\n    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'\n  \bcmd\bvim\1\0\2\fmapping\0\fsources\0\6:\1\0\2\fmapping\0\fsources\0\vpreset\1\3\0\0\6/\6?\fcmdline\15formatting\vformat\1\0\1\vformat\0\vbefore\0\1\0\4\rmaxwidth\0032\14with_text\2\vbefore\0\tmode\16symbol_text\15cmp_format\ttmux\tpath\vbuffer\rsnippets\rnvim_lsp\t<cr>\1\0\1\vselect\2\fconfirm\n<c-.>\rcomplete\n<c-e>\nabort\n<c-p>\21select_prev_item\n<c-n>\1\0\5\n<c-n>\0\n<c-.>\0\n<c-e>\0\n<c-p>\0\t<cr>\0\21select_next_item\fsnippet\vexpand\1\0\1\vexpand\0\0\rmatching\1\0\5\fmapping\0\fsnippet\0\15formatting\0\rmatching\0\fsources\0\1\0\1\28disallow_fuzzy_matching\1\nsetup\0\flspkind\btap\fforEach\15kaineer.fn\fsources\vconfig\fmapping\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: vim-gist
time([[Config for vim-gist]], true)
try_loadstring("\27LJ\2\nÅ\2\0\0\b\0\b\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0006\3\3\0009\3\4\0035\4\5\0006\5\0\0'\a\6\0B\5\2\2=\5\a\4B\1\3\1K\0\1\0\15gist_token\24plugins.gist.secret\1\0\a\15gist_token\0\22gist_clip_command\31xclip -selection clipboard\16github_user\fkaineer\27gist_get_multiple_file\3\1\24gist_browser_comand\26brave-browser %URL% &!gist_open_browser_after_post\3\1\23gist_show_privates\3\1\6g\bvim\vassign\15kaineer.fn\frequire\0", "config", "vim-gist")
time([[Config for vim-gist]], false)
-- Config for: hurl.nvim
time([[Config for hurl.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\thurl\frequire\0", "config", "hurl.nvim")
time([[Config for hurl.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n¦\2\0\0\6\0\17\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0025\3\5\0B\0\3\0016\0\0\0'\2\6\0B\0\2\0029\0\a\0005\2\r\0005\3\v\0004\4\4\0005\5\b\0>\5\1\0045\5\t\0>\5\2\0045\5\n\0>\5\3\4=\4\f\3=\3\14\0025\3\15\0=\3\16\2B\0\2\1K\0\1\0\fplugins\1\0\1\14registers\1\freplace\1\0\2\freplace\0\fplugins\0\bkey\1\0\1\bkey\0\1\3\0\0\n<tab>\bTAB\1\3\0\0\t<cr>\aCR\1\3\0\0\f<space>\bSPC\nsetup\14which-key\1\0\2\15timeoutlen\3 \6\ftimeout\2\6o\bvim\vassign\15kaineer.fn\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: telekasten.nvim
time([[Config for telekasten.nvim]], true)
try_loadstring("\27LJ\2\nà\6\0\0\a\0\24\0-6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0B\1\2\0026\2\0\0'\4\6\0B\2\2\0029\2\a\0025\4\b\0=\1\t\4\18\5\1\0'\6\n\0&\5\6\5=\5\v\4\18\5\1\0'\6\f\0&\5\6\5=\5\r\4\18\5\1\0'\6\14\0&\5\6\5=\5\15\4B\2\2\0019\2\16\0004\4\b\0005\5\17\0>\5\1\0045\5\18\0>\5\2\0045\5\19\0>\5\3\0045\5\20\0>\5\4\0045\5\21\0>\5\5\0045\5\22\0>\5\6\0045\5\23\0>\5\a\4B\2\2\1K\0\1\0\1\3\0\0\14<leader>z\20:Telekasten<cr>\1\3\0\0\15<leader>zt :Telekasten toggle_todo<cr>\1\3\0\0\16<leader>zgt\31:Telekasten goto_today<cr>\1\3\0\0\15<leader>zs!:Telekasten search_notes<cr>\1\3\0\0\15<leader>zn\31:Telekasten find_notes<cr>\1\3\0\0\15<leader>zd%:Telekasten find_daily_notes<cr>\1\3\0\0\15<leader>zw&:Telekasten find_weekly_notes<cr>\vnormal\14templates\15/templates\rweeklies\f/weekly\fdailies\v/daily\thome\1\0\r\31follow_creates_nonexisting\2\26command_palette_theme\bivy\14extension\b.md\14templates\0\rweeklies\0\fdailies\0\22auto_set_filetype\2\22take_over_my_home\2\24rename_update_links\2\thome\0\20show_tags_theme\bivy weeklies_create_nonexisting\2\31dailies_create_nonexisting\2\nsetup\15telekasten\23~/git/notes/kasten\vexpand\afn\bvim\16kaineer.map\frequire\0", "config", "telekasten.nvim")
time([[Config for telekasten.nvim]], false)
-- Config for: kulala.nvim
time([[Config for kulala.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vkulala\frequire\0", "config", "kulala.nvim")
time([[Config for kulala.nvim]], false)
-- Config for: vim-json
time([[Config for vim-json]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0\20set foldlevel=1\26set foldmethod=syntax\bcmd\bvimP\1\1\6\0\4\0\a\18\1\0\0'\3\0\0005\4\1\0003\5\2\0=\5\3\4B\1\3\1K\0\1\0\rcallback\0\1\0\2\rcallback\0\fpattern\tjson\rFileType°\1\1\0\6\0\t\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0\18\1\0\0'\3\3\0003\4\4\0B\1\3\1\18\1\0\0'\3\5\0005\4\a\0005\5\6\0=\5\b\4B\1\3\1K\0\1\0\fpattern\1\0\2\fcommand\16set ft=json\fpattern\0\1\3\0\0\v.swcrc\14.eslintrc\fBufRead\0\16JsonFolding\aau\20kaineer.autocmd\frequire\0", "config", "vim-json")
time([[Config for vim-json]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\3\0\t6\0\0\0'\2\1\0B\0\2\2B\0\1\0016\0\0\0'\2\2\0B\0\2\2B\0\1\1K\0\1\0\22plugins.lsp.mason\24plugins.lsp.servers\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: vim-projectionist
time([[Config for vim-projectionist]], true)
try_loadstring("\27LJ\2\nß\2\0\0\t\0\f\0 '\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\1\18\3\0\0B\1\2\0026\2\1\0'\4\4\0B\2\2\0029\2\5\0024\4\4\0005\5\6\0\18\6\1\0'\b\a\0B\6\2\2>\6\2\5>\5\1\0045\5\b\0\18\6\1\0'\b\t\0B\6\2\2>\6\2\5>\5\2\0045\5\n\0\18\6\1\0'\b\v\0B\6\2\2>\6\2\5>\5\3\4B\2\2\1K\0\1\0\aAV\1\2\1\0\b av\tdesc#Projectionist alternate vsplit\aAS\1\2\1\0\b as\tdesc\"Projectionist alternate split\6A\1\2\1\0\b aa\tdesc\28Projectionist alternate\badd\14which-key\15buildMkcmd\16kaineer.cmd\frequire+Could not find projectionist alternate\0", "config", "vim-projectionist")
time([[Config for vim-projectionist]], false)
-- Config for: nvim-snippets
time([[Config for nvim-snippets]], true)
try_loadstring("\27LJ\2\nÃ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\23extended_filetypes\15typescript\1\0\1\15typescript\0\1\2\0\0\15javascript\1\0\3\22create_cmp_source\2\23extended_filetypes\0\22friendly_snippets\2\nsetup\rsnippets\frequire\0", "config", "nvim-snippets")
time([[Config for nvim-snippets]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n¥\b\0\0\v\0*\0009'\0\0\0'\1\1\0'\2\2\0'\3\3\0006\4\4\0'\6\5\0B\4\2\0029\4\6\0045\6\21\0005\a\a\0005\b\b\0=\0\t\b=\1\n\b=\b\v\a5\b\f\0=\2\t\b=\3\n\b=\b\r\a5\b\14\0004\t\0\0=\t\15\b4\t\0\0=\t\16\b=\b\17\a4\b\0\0=\b\18\a5\b\19\0=\b\20\a=\a\22\0065\a\24\0005\b\23\0=\b\25\a5\b\26\0=\b\27\a4\b\3\0005\t\28\0005\n\29\0=\n\30\t>\t\1\b=\b\31\a5\b \0=\b!\a5\b\"\0=\b#\a5\b$\0=\b%\a=\a&\0064\a\0\0=\a'\0064\a\0\0=\a\16\0064\a\0\0=\a(\0064\a\0\0=\a)\6B\4\2\1K\0\1\0\15extensions\20inactive_winbar\ftabline\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\fsymbols\1\0\4\funnamed\b[ ]\rreadonly\b[-]\fnewfile\t[Ã—]\rmodified\b[+]\1\2\2\0\rfilename\fsymbols\0\tpath\3\2\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\6\14lualine_a\0\14lualine_y\0\14lualine_z\0\14lualine_x\0\14lualine_c\0\14lualine_b\0\1\2\0\0\tmode\foptions\1\0\6\foptions\0\rsections\0\ftabline\0\15extensions\0\20inactive_winbar\0\vwinbar\0\frefresh\1\0\3\vwinbar\3è\a\ftabline\3è\a\15statusline\3è\a\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\2\vwinbar\0\15statusline\0\23section_separators\1\0\2\tleft\0\nright\0\25component_separators\nright\tleft\1\0\2\tleft\0\nright\0\1\0\t\23disabled_filetypes\0\23section_separators\0\ntheme\tnord\25component_separators\0\18icons_enabled\2\frefresh\0\17globalstatus\2\25always_divide_middle\2\17ignore_focus\0\nsetup\flualine\frequire\bî‚²\bî‚°\bî‚³\bî‚±\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: eyeliner.nvim
time([[Config for eyeliner.nvim]], true)
try_loadstring("\27LJ\2\ng\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\bdim\2\21highlight_on_key\2\nmatch\17[A-Za-z0-9.]\nsetup\reyeliner\frequire\0", "config", "eyeliner.nvim")
time([[Config for eyeliner.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÛ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21ensure_installed\1\f\0\0\tyaml\blua\thttp\bcpp\vpython\truby\trust\tmake\btsx\15javascript\vvimdoc\vindent\1\0\2\21ensure_installed\0\vindent\0\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-tmux-navigator
time([[Config for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n!\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\6>\b<m-2\0\2\6\0\2\0\6\18\2\0\0'\3\0\0\18\4\1\0'\5\1\0&\2\5\2L\2\2\0\t<cr>\18:TmuxNavigateþ\1\1\0\23\0\b\1#6\0\0\0'\2\1\0B\0\2\0023\1\2\0003\2\3\0005\3\4\0005\4\5\0006\5\6\0\18\a\3\0B\5\2\4H\b\21€6\n\6\0\18\f\4\0B\n\2\4H\r\15€9\15\a\0004\17\3\0004\18\3\0\18\19\1\0\18\21\r\0B\19\2\2>\19\1\18\18\19\2\0\18\21\t\0\18\22\14\0B\19\3\0?\19\0\0>\18\1\17\18\18\b\0B\15\3\1F\r\3\3R\rï\127F\b\3\3R\bé\127K\0\1\0\tmode\npairs\1\0\5\6l\nRight\6j\tDown\6h\tLeft\6o\rPrevious\6k\aUp\1\0\3\6t\15<c-\\><c-n>\6n\5\6i\n<c-[>\0\0\16kaineer.map\frequire\5€€À™\4\0", "config", "vim-tmux-navigator")
time([[Config for vim-tmux-navigator]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Config for: boringcomment.nvim
time([[Config for boringcomment.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\29comment_visual_selection.\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\25comment_current_line‹\1\1\0\6\0\n\0\0196\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\6\0003\5\a\0B\1\4\0016\1\2\0009\1\3\0019\1\4\1'\3\b\0'\4\6\0003\5\t\0B\1\4\0012\0\0€K\0\1\0\0\6n\0\agc\6x\bset\vkeymap\bvim\28boringcomment.commenter\frequire\0", "config", "boringcomment.nvim")
time([[Config for boringcomment.nvim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\n¹\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\b\tmode\vcursor\vzindex\3\20\15trim_scope\nouter\24multiline_threshold\3\20\17line_numbers\2\22min_window_height\3\0\14max_lines\3\1\venable\2\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: mkdnflow.nvim
time([[Config for mkdnflow.nvim]], true)
try_loadstring("\27LJ\2\nˆ\3\0\0\6\0\18\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0005\4\f\0005\5\v\0>\5\1\4=\4\r\0035\4\15\0005\5\14\0>\5\1\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\rmappings\20MkdnTableFormat\1\3\0\0\0\15<leader>mf\1\2\0\0\6n\14MkdnEnter\1\3\0\0\0\n<c-j>\1\4\0\0\6n\6v\6i\1\0\4\24MkdnDecreaseHeading\1\24MkdnIncreaseHeading\1\20MkdnTableFormat\0\14MkdnEnter\0\14filetypes\1\0\2\amd\2\rmarkdown\2\nlinks\1\0\1\fconceal\2\fmodules\1\0\2\vtables\2\nfolds\2\1\0\5\rmappings\0\14filetypes\0\nlinks\0\fmodules\0\vsilent\2\nsetup\rmkdnflow\frequire\0", "config", "mkdnflow.nvim")
time([[Config for mkdnflow.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n\"\0\1\4\0\2\0\5'\1\0\0\18\2\0\0'\3\1\0&\1\3\1L\1\2\0\t<cr>\6:(\0\1\5\1\1\0\5-\1\0\0'\3\0\0\18\4\0\0&\3\4\3D\1\2\0\3À\15Telescope ,\0\1\4\1\1\0\5-\1\0\0009\1\0\1\18\3\0\0B\1\2\1K\0\1\0\1À\19load_extension÷\t\1\0\16\0001\2\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\0\0'\3\3\0B\1\2\0026\2\0\0'\4\4\0B\2\2\0023\3\5\0003\4\6\0005\5\a\0003\6\b\0006\a\0\0'\t\t\0B\a\2\0029\a\n\aB\a\1\2\18\b\0\0\18\n\5\0\18\v\6\0B\b\3\0019\b\v\0015\n\f\0=\a\r\n5\v\18\0005\f\16\0004\r\3\0005\14\14\0>\14\1\r5\14\15\0>\14\2\r=\r\17\f=\f\19\v4\f\3\0006\r\0\0'\15\t\0B\r\2\0029\r\20\r4\15\0\0B\r\2\0?\r\0\0=\f\21\v5\f\22\0=\f\23\v=\v\24\nB\b\2\0019\b\25\0024\n\15\0005\v\26\0\18\f\4\0'\14\27\0B\f\2\0?\f\1\0>\v\1\n5\v\28\0\18\f\4\0'\14\29\0B\f\2\0?\f\1\0>\v\2\n5\v\30\0\18\f\4\0'\14\23\0B\f\2\0?\f\1\0>\v\3\n5\v\31\0\18\f\4\0'\14 \0B\f\2\0?\f\1\0>\v\4\n5\v!\0\18\f\4\0'\14\"\0B\f\2\0?\f\1\0>\v\5\n5\v#\0\18\f\4\0'\14$\0B\f\2\0?\f\1\0>\v\6\n5\v%\0\18\f\4\0'\14&\0B\f\2\0?\f\1\0>\v\a\n5\v'\0\18\f\4\0'\14(\0B\f\2\0?\f\1\0>\v\b\n5\v)\0\18\f\4\0'\14(\0B\f\2\0?\f\1\0>\v\t\n5\v*\0\18\f\4\0'\14+\0B\f\2\0?\f\1\0>\v\n\n5\v,\0\18\f\4\0'\14-\0B\f\2\0?\f\1\0>\v\v\n5\v.\0\18\f\4\0'\14\19\0B\f\2\0?\f\1\0>\v\f\n5\v/\0>\v\r\n5\v0\0>\v\14\nB\b\2\0012\0\0€K\0\1\0\1\3\0\0\16<leader>oup\24:UrlView packer<cr>\1\3\0\0\16<leader>ouu\17:UrlView<cr>\1\2\0\0\15<leader>op\14live_grep\1\2\0\0\15<leader>rg\16diagnostics\1\2\0\0\15<leader>od\1\2\0\0\14<leader>/\30current_buffer_fuzzy_find\1\2\0\0\15<leader>ol\14registers\1\2\0\0\15<leader>or\fkeymaps\1\2\0\0\15<leader>om\14git_files\1\2\0\0\15<leader>og\roldfiles\1\2\0\0\15<leader>oh\1\2\0\0\15<leader>ot\fbuffers\1\2\0\0\15<leader>ob\15find_files\1\2\0\0\15<leader>of\vnormal\15extensions\17file_browser\1\0\2\ntheme\bivy\17hijack_netrw\1\14ui-select\15get_cursor\fproject\1\0\3\17file_browser\0\14ui-select\0\fproject\0\14base_dirs\1\0\2\ntheme\bivy\14base_dirs\0\1\0\2\14max_depth\3\3\tpath$/home/kaineer/devel/htmlacademy\1\0\2\14max_depth\3\3\tpath\22/home/kaineer/git\rdefaults\1\0\2\15extensions\0\rdefaults\0\nsetup\fget_ivy\21telescope.themes\0\1\3\0\0\fproject\14ui-select\0\0\16kaineer.map\14telescope\fforEach\15kaineer.fn\frequire\3€€À™\4\5€€À™\4\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: vim-dirvish
time([[Config for vim-dirvish]], true)
try_loadstring("\27LJ\2\nQ\0\0\4\3\4\0\n6\0\0\0009\0\1\0+\1\1\0=\1\2\0-\0\0\0009\0\3\0-\2\1\0-\3\2\0B\0\3\1K\0\1\0\0\0\1\0\2\0\vbuffer\vnumber\14opt_local\bvimY\1\1\6\3\4\0\a\18\1\0\0'\3\0\0005\4\1\0003\5\2\0=\5\3\4B\1\3\1K\0\1\0\1À\3À\2À\rcallback\0\1\0\2\rcallback\0\fpattern\fdirvish\rFileType—\2\1\0\b\0\r\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\0\0'\3\3\0B\1\2\0025\2\4\0004\3\a\0005\4\5\0>\4\1\0035\4\6\0>\4\2\0035\4\a\0>\4\3\0035\4\b\0>\4\4\0035\4\t\0>\4\5\0035\4\n\0>\4\6\3\18\4\0\0'\6\v\0003\a\f\0B\4\3\0012\0\0€K\0\1\0\0\15DirvishNav\1\3\0\0\14<m-enter>\23:!nemo % &<cr><cr>\1\3\0\0\6m\14:!mkdir %\1\3\0\0\6r\f.rm -rf\1\3\0\0\6e\t:e %\1\3\0\0\6l\t<cr>\1\3\0\0\6h\6-\1\0\2\fnoremap\1\vsilent\1\16kaineer.map\aau\20kaineer.autocmd\frequire\0", "config", "vim-dirvish")
time([[Config for vim-dirvish]], false)
-- Config for: nord.nvim
time([[Config for nord.nvim]], true)
try_loadstring("\27LJ\2\n‰\3\0\0\5\0\16\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0006\1\3\0009\1\4\1'\3\5\0B\1\2\1\18\1\0\0006\3\3\0009\3\6\0035\4\a\0B\1\3\0016\1\3\0009\1\4\1'\3\b\0B\1\2\0016\1\0\0'\3\t\0B\1\2\0029\1\n\0015\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\3B\1\2\1K\0\1\0\16backgrounds\1\4\0\0\vNormal\vLineNr\15SignColumn\vcolors\1\0\2\16backgrounds\0\vcolors\0\1\0\2\vactive\19 guibg=#2e3440\rinactive\19 guibg=#4b556a\nsetup\30plugins.colorscheme.focus\29:hi Delimiter ctermfg=15\1\0\2\18nord_contrast\1\28nord_disable_background\2\6g\21colorscheme nord\bcmd\bvim\vassign\15kaineer.fn\frequire\0", "config", "nord.nvim")
time([[Config for nord.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nm\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15javascript\1\0\1\15javascript\0\1\0\1\tmode\fvirtual\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: urlview.nvim
time([[Config for urlview.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\19default_picker\14telescope\nsetup\furlview\frequire\0", "config", "urlview.nvim")
time([[Config for urlview.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
