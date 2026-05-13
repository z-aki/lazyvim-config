return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.DiffDeleteText = { bg = c.red, fg = c.bg_dark, bold = true }
        hl.DiffAddText = { bg = c.green, fg = c.bg_dark, bold = true }
      end,
    },
  },
}
