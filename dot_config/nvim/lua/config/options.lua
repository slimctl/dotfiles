-- use osc52 over ssh sessions
if os.getenv("SSH_TTY") or (not os.getenv("DISPLAY") and not os.getenv("WAYLAND_DISPLAY")) then
  local osc52 = require("vim.ui.clipboard.osc52")

  local function sync_clipboard()
    local content = vim.v.event.regcontents
    osc52.copy("+")(content)
    osc52.copy("*")(content)
  end

  vim.api.nvim_create_autocmd("TextYankPost", { callback = sync_clipboard })
else
  vim.o.clipboard = "unnamedplus"
end

-- python
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
