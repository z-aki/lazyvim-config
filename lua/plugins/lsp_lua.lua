return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "]]", false },
            { "[[", false },
            { "gd", false },
            { "gr", false },
            { "gI", false },
            { "K", false },
          },
        },
        jdtls = {},
        sourcekit = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim", "require" },
              },
            },
          },
        },
      },
      setup = {
        jdtls = function()
          return true
        end,
      },
    },
  },
}
