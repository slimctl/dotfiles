-- Sync lazy-lock.json back into chezmoi whenever lazy changes plugins
vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyUpdate", "LazySync", "LazyInstall", "LazyClean", "LazyRestore" },
  callback = function()
    vim.fn.jobstart({ "chezmoi", "re-add", vim.fn.stdpath("config") .. "/lazy-lock.json" })
  end,
})
