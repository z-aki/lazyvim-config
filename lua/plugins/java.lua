return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings ={
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = vim.fn.expand("~/.sdkman/candidates/java/17.0.18-amzn"),
                default = false
              },
              {
                name = "JavaSE-21",
                path = vim.fn.expand("~/.sdkman/candidates/java/21.0.10-amzn"),
                default = true
              },
              {
                name = "JaveSE-1.8",
                path = vim.fn.expand("~/.sdkman/candidates/java/8.0.472-amzn"),
                default = false
              }
            },
          },
          completion = {
            maxResults = 0
          }
        }
      }
    }
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
    end
  }
}
