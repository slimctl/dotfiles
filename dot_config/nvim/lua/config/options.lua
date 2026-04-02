vim.o.clipboard = "unnamedplus"

if os.getenv("SSH_TTY") then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = function()
        return vim.fn.getreg("+", 1, true)
      end,
      ["*"] = function()
        return vim.fn.getreg("*", 1, true)
      end,
    },
  }
end
