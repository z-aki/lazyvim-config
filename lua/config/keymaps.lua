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

vim.keymap.set("n", "<leader>fx", function()
  local path = vim.fn.expand("%:p")
  vim.cmd("silent !open -R " .. vim.fn.shellescape(path))
end, { desc = "Reveal current file in Finder" })

vim.keymap.set("n", "<leader>gx", function()
  vim.fn.jobstart({ "smerge", "--project", vim.fn.expand("%:p:h") }, { detach = true })
end, { desc = "Open repo in sublime merge" })

vim.keymap.set("n", "<leader><Tab><Tab>", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })

vim.keymap.set(
  "n",
  "<leader>gP",
  "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
  { desc = "Diffview PR review" }
)

vim.keymap.set("n", "]]", "]h", { remap = true })
vim.keymap.set("n", "[[", "[h", { remap = true })

-- Generic fast LSP helper: try LSP first, fallback to grep
local function fast_lsp(lsp_method, fzf_lsp_func, fallback_func)
  return function()
    local fzf = require("fzf-lua")
    local search_term = vim.fn.expand("<cword>")
    -- ms
    local timeout = 1000

    -- Get jdtls or any active client for current buffer
    local clients = vim.lsp.get_clients({ name = "jdtls", bufnr = 0 })
    if #clients == 0 then
      clients = vim.lsp.get_clients({ bufnr = 0 })
    end
    local client = clients[1]

    -- If LSP exists and supports the method, attempt the sync request
    if client and client.supports_method(lsp_method, 0) then
      local params = vim.lsp.util.make_position_params(nil, client.offset_encoding)
      if lsp_method == "textDocument/references" then
        ---@diagnostic disable-next-line: inject-field
        params.context = { includeDeclaration = true }
      end
      local success, result = pcall(vim.lsp.buf_request_sync, 0, lsp_method, params, timeout)

      -- Check if we got actual LSP results
      local has_results = false
      if success and result then
        for _, response in pairs(result) do
          if response.result and #response.result > 0 then
            has_results = true
            break
          end
        end
      end

      if has_results then
        fzf_lsp_func({ query = search_term })
      else
        (fallback_func or fzf.live_grep)({ query = search_term })
      end
    else
      -- No LSP support, go straight to grep
      (fallback_func or fzf.live_grep)({ query = search_term })
    end
  end
end

vim.keymap.set(
  "n",
  "gd",
  fast_lsp("textDocument/definition", require("fzf-lua").lsp_definitions),
  { desc = "Fast Goto Definition (FzfLua)" }
)
vim.keymap.set(
  "n",
  "gr",
  fast_lsp("textDocument/references", require("fzf-lua").lsp_references),
  { desc = "Fast Goto References (FzfLua)" }
)
vim.keymap.set(
  "n",
  "gI",
  fast_lsp("textDocument/implementation", require("fzf-lua").lsp_implementations),
  { desc = "Fast Goto Implementation (FzfLua)" }
)



-- Copy relative path
vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path: " .. path)
end, { desc = "Copy Relative Path" })

-- Copy absolute path
vim.keymap.set("n", "<leader>fY", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path: " .. path)
end, { desc = "Copy Absolute Path" })
