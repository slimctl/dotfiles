vim.o.clipboard = "unnamedplus"

-- use osc52 over ssh sessions
if os.getenv("SSH_TTY") then
  local osc52 = require("vim.ui.clipboard.osc52")

  local function sync_clipboard()
    local content = vim.v.event.regcontents
    osc52.copy("+")(content)
    osc52.copy("*")(content)
  end

  vim.api.nvim_create_autocmd("TextYankPost", { callback = sync_clipboard() })
end
