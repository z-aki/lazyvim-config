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
        jdtls = {
          settings = {
            java = {
              completion = {
                maxResults = 0
              }
            }
          }
        }
        ,
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
