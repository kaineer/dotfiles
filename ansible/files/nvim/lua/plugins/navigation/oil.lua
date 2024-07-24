local setupOil = function()
  local assign = require("kaineer.fn").assign

  vim.cmd([[
    command! -nargs=? -complete=dir Explore Oil <args>
  ]])

  assign(vim.g, {
    loaded_netrwPlugin = 1,
  })
  vim.api.nvim_create_user_command(
    'Browse',
    function (opts)
      vim.fn.system { 'xdg-open', opts.fargs[1] }
    end,
    { nargs = 1 }
  )
end

pcall(setupOil)

return {
  "stevearc/oil.nvim",
  setup = setupOil,
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
        -- "size",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["l"] = "actions.select",
        ["h"] = "actions.parent",
      },
    })

    local bindings = {
      { '-', ":Oil<cr>" },
    }

    require("kaineer.map").normal(bindings)
  end,
}
