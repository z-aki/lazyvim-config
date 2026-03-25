return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ['*'] = {
          keys = {
            { "]]", false},
            { "[[", false }
          },
        },
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
    },
  },
}
