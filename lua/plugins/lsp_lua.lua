return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ['*'] = {
          keys = {
            { "]]", false},
            { "[[", false },
            { "gd", false }
          },
        },
        jdtls = {

        }
        ,
        sourcekit = {

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
      setup = {
        jdtls = function()
          return true
        end
      }
    },
  },
}
