return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
      },
      linters = {
        ["markdownlint-cli2"] = {
          prepend_args = { "--config", vim.fn.stdpath("config") .. "/markdownlint-cli2.jsonc" },
        },
      },
    },
  },
}
