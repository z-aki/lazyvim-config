return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required

    -- Only one of these is needed.
    "sindrets/diffview.nvim", -- optional
    -- "esmuellert/codediff.nvim", -- optional

    -- Only one of these is needed.
    -- "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
    -- "nvim-mini/mini.pick", -- optional
    -- "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  opts = {
    integrations = {
      diffview = true,
      fzf_lua = true,
    },
    kind = "auto"
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    { "<leader>gP", '<cmd>DiffviewOpen origin/master...HEAD --imply-local<cr>', desc = "Show Diffview UI" },
  },
}
