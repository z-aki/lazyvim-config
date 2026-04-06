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
    },
  },
}
