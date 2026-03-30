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


vim.keymap.set('n', '<leader>fx', function()
  local path = vim.fn.expand('%:p')
  vim.cmd('silent !open -R ' .. vim.fn.shellescape(path))
end, { desc = "Reveal current file in Finder" })

vim.keymap.set('n', '<leader>gx', function()
  vim.fn.jobstart({ "smerge", "--project", vim.fn.expand("%:p:h") }, { detach = true })
end, {desc = "Open repo in sublime merge"})

vim.keymap.set('n', '<leader><Tab><Tab>', '<Cmd>tabprevious<CR>', {desc = 'Previous Tab'})

vim.keymap.set('n', "<leader>gP", '<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>', {desc = "Diffview PR review"})

vim.keymap.set('n', "]]", "]h", { remap = true })
vim.keymap.set('n', "[[", "[h", { remap = true })
