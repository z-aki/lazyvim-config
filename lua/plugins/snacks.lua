return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>fR",
      function()
        LazyVim.pick("oldfiles")
      end,
      desc = "Recent",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter = { cwd = true } })
      end,
      desc = "Recent (cwd)",
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    },
  },
}
