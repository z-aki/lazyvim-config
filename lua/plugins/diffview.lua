return {
  {
    "sindrets/diffview.nvim",
    opts = {
      hooks = {
        diff_buf_win_enter = function(bufnr, winid, ctx)
          -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
          -- the right.
          if ctx.layout_name:match("^diff2") then
            if ctx.symbol == "a" then
              vim.opt_local.winhl = table.concat({
                "DiffAdd:DiffviewDiffAddAsDelete",
                "DiffDelete:DiffviewDiffDelete",
                "DiffChange:DiffAddAsDelete",
                "DiffText:DiffDeleteText",
              }, ",")
            elseif ctx.symbol == "b" then
              vim.opt_local.winhl = table.concat({
                "DiffDelete:DiffviewDiffDelete",
                "DiffChange:DiffAdd",
                "DiffText:DiffAddText",
              }, ",")
            end
          end
        end,
      },
    },
  },
}
