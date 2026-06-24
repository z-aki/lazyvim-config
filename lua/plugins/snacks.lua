return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = false,
      },
      input = {
        enabled = false,
      },
      dashboard = {
        enabled = true,
        sections = {
          {
            title = "Branch",
            cmd = "git branch --show-current 2>/dev/null",
            height = 1,
            section = "terminal",
            padding = 1,
            align = "left",
            pane = 1,
          },
          {
            title = "Recent Files",
            section = "recent_files",
            cwd = true,
            limit = 8,
            padding = 1,
            align = "left",
            pane = 1,
          },
          { section = "startup", pane = 1 },
          {
            title = "Git Status <leader>gs",
            cmd = 'git status --short 2>/dev/null | awk \'{n=split($NF,a,"/"); print substr($0,1,3) (n>1?a[n-1]"/"a[n]:a[1])}\'',
            height = 5,
            section = "terminal",
            padding = 0,
            indent = 0,
            align = "left",
            pane = 2,
          },
          {
            title = "PR Status <leader>gp",
            cmd = "gh pr status 2>/dev/null",
            height = 15,
            section = "terminal",
            padding = 1,
            align = "left",
            pane = 2,
          },
        },
      },
    },
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
  },
  {
    "folke/noice.nvim",
    enabled = true,
    opts = {
      cmdline = {
        -- enabled = false,
      },
      messages = {
        -- enabled = false
      },
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
