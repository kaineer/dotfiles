return {
  urls = {
    "https://github.com/b0o/incline.nvim",
  },
  setup = function()
    local function filename(buf)
      local name = vim.api.nvim_buf_get_name(buf)
      if name == "" then
        return "[No Name]"
      end
      return vim.fn.fnamemodify(name, ":t")
    end

    local function git_branch(buf)
      local ok, head = pcall(function()
        return vim.api.nvim_buf_call(buf, function()
          return vim.fn.FugitiveHead()
        end)
      end)
      if ok and type(head) == "string" and head ~= "" then
        return head
      end
      return nil
    end

    local function filetype(buf)
      local ft = vim.bo[buf].filetype
      if type(ft) == "string" and ft ~= "" then
        return ft
      end
      return nil
    end

    local function location(win)
      -- nvim_win_call keeps only the first return value
      return vim.api.nvim_win_call(win, function()
        local line = vim.fn.line(".")
        local col = vim.fn.col(".")
        local total = vim.fn.line("$")
        local pct
        if total <= 1 then
          pct = "All"
        elseif line == 1 then
          pct = "Top"
        elseif line == total then
          pct = "Bot"
        else
          pct = string.format("%d%%", math.floor((line - 1) / (total - 1) * 100))
        end
        return { pct = pct, line = line, col = col }
      end)
    end

    local function display_width(node)
      local ok, winline = pcall(require, "incline.winline")
      if ok and type(winline.parse_render_result) == "function" then
        local content = winline.parse_render_result(node)
        return vim.fn.strdisplaywidth(content.text or "")
      end
      return 0
    end

    require("incline").setup({
      window = {
        placement = { horizontal = "right", vertical = "top" },
        margin = { horizontal = 0, vertical = 0 },
        padding = 0,
        width = "fill",
      },
      highlight = {
        groups = {
          InclineNormal = { guibg = "#81a1c1", guifg = "#2e3440" },
          InclineNormalNC = { guibg = "#4c566a", guifg = "#d8dee9" },
        },
      },
      render = function(props)
        local modified = vim.bo[props.buf].modified
        local name = filename(props.buf)
        local branch = git_branch(props.buf)
        local ft = filetype(props.buf)
        local loc = location(props.win)
        local width = vim.api.nvim_win_get_width(props.win)

        local left = {
          " ",
          branch and { " " .. branch .. " ", guifg = "#d8dee9" } or "",
          { name, gui = modified and "bold,italic" or "bold" },
          modified and { " ●", guifg = "#ebcb8b" } or "",
          ft and { "  " .. ft, guifg = "#eceff4" } or "",
        }

        local right = {
          { loc.pct .. "  ", guifg = "#eceff4" },
          { string.format("%d:%d", loc.line, loc.col), guifg = "#eceff4" },
          " ",
        }

        local gap = width - display_width(left) - display_width(right)
        if gap < 1 then
          gap = 1
        end

        return {
          left,
          string.rep(" ", gap),
          right,
          guibg = props.focused and "#81a1c1" or "#4c566a",
          guifg = props.focused and "#2e3440" or "#d8dee9",
        }
      end,
    })

    -- Content is shown via nvim-filename; keep incline's floats off.
    require("incline").disable()
    vim.opt.laststatus = 0
  end,
}
