return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_b, 1, {
      function()
        -- Get the full path and take only the last part (the folder name)
        local path = LazyVim.root()
        return vim.fn.fnamemodify(path, ":t")
      end,
    })
  end,
}
