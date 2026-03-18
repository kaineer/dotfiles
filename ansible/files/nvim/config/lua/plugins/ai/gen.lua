return {
  "David-Kunz/gen.nvim",
  opts = {
    -- model = "gemma2:2b",
    -- model = "qwen3.5",
    host = "10.1.0.72",
    port = "11434",
    model = "gemma3:4b",
    display_mode = "vertical-split",
    result_filetype = "text",
  },
  init = function()
    require("gen").prompts["UseClipboard"] = {
      prompt = "$register. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = false,
    }
  end,
}
