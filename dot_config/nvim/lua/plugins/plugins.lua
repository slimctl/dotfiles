return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre", -- optional: lazy-load on buffer read
    config = function()
      require("colorizer").setup({
        "*", -- highlight all files
      }, {
        mode = "background", -- show colors as background
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "shellcheck",
        "shfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
      },
    },
  },
}
