return {
  url = "https://github.com/nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      override_by_extension = {
        yaml = { icon = "", color = "#bf616a", name = "Yaml" },
        yml = { icon = "", color = "#bf616a", name = "Yml" },
      }
    })
  end,
}
