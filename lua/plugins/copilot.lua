return {
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      local node_path = vim.fn.glob("~/.nvm/versions/node/v2*/bin/node", true, true)
      return {
        copilot_node_command = node_path[#node_path],
      }
    end,
  },
}
