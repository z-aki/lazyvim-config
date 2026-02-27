-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ii", function()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")

  local cmd = { "idea", "--line", tostring(line), "--column", tostring(col), file }

  vim.fn.jobstart(cmd, { detach = true })
  print("Opening in IntelliJ...")
end, { desc = "Open current file in IntelliJ" })
