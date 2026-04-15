return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- Add custom JVM args to the cmd
      local jvm_args = {
        "-Xms2g",
        "-Xmx40g",
        "-XX:+UseParallelGC",
        "-XX:GCTimeRatio=4",
        "-XX:AdaptiveSizePolicyWeight=90",
        "-Dsun.zip.disableMemoryMapping=true",
        "-Xlog:disable",
      }

      for _, arg in ipairs(jvm_args) do
        table.insert(opts.cmd, string.format("--jvm-arg=%s", arg))
      end

      -- Add custom settings
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = vim.fn.expand("~/.sdkman/candidates/java/17.0.18-amzn"),
                default = false,
              },
              {
                name = "JavaSE-21",
                path = vim.fn.expand("~/.sdkman/candidates/java/21.0.10-amzn"),
                default = true,
              },
              {
                name = "JaveSE-1.8",
                path = vim.fn.expand("~/.sdkman/candidates/java/8.0.472-amzn"),
                default = false,
              },
            },
          },
          completion = {
            maxResults = 0,
          },
        },
      })

      return opts
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function() end,
  },
}
