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
    opts = function(_, opts)
      local default_cmd = require("fzf-lua").config.defaults.git.status.cmd

      -- respect the config in the repo for untracked cached files https://git-scm.com/docs/git-status#_untracked_files_and_performance
      local filtered_cmd = default_cmd:gsub("%s+-u%s*", "")

      opts.git = opts.git or {}
      opts.git.status = vim.tbl_deep_extend("force", opts.git.status or {}, {
        cmd = filtered_cmd,
      })

      opts.files = {
        fzf_opts = {
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
        },
        cwd_prompt = false,
      }
      opts.grep = {
        fzf_opts = {
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
        },
      }
      return opts
    end,
    keys = {
      { "<leader>fR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    },
  },
}
