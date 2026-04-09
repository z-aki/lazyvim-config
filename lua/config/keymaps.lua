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

-- Fast definition: try LSP first, fallback to grep
local function fast_definition()
  local fzf = require("fzf-lua")
  local search_term = vim.fn.expand("<cword>")
  local timeout = 5
  local has_results = false

  -- Get jdtls or any active client for current buffer
  local clients = vim.lsp.get_clients({ name = 'jdtls', bufnr = 0 })
  if #clients == 0 then clients = vim.lsp.get_clients({ bufnr = 0 }) end
  local client = clients[1]

  -- If LSP exists and supports the method, attempt the sync request
  if client and client.supports_method("textDocument/definition", 0) then
    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    local success, result = pcall(vim.lsp.buf_request_sync, 0, "textDocument/definition", params, timeout)
    has_results = success and result and not vim.tbl_isempty(result)
  end

  -- Single point of decision for the UI call
  if has_results then
    fzf.lsp_definitions({ query = search_term })
  else
    fzf.live_grep({ query = search_term })
  end
end

vim.keymap.set('n', 'gd', fast_definition, { desc = "Fast Goto Definition (FzfLua)" })
