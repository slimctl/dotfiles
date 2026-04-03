return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        jinja_lsp = {
          filetypes = { "jinja", "jinja2" },
        },
      },
    },
  },
}
