return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        "*",
      }, {
        mode = "background",
      })
    end,
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = { "jinja", "jinja2", "htmldjango" },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "LazyVim",
    opts = function()
      vim.filetype.add({
        extension = {
          j2 = "jinja2",
          jinja = "jinja2",
          jinja2 = "jinja2",
          ["ini.j2"] = "jinja2",
          ["yaml.j2"] = "jinja2",
          ["yml.j2"] = "jinja2",
          ["toml.j2"] = "jinja2",
          ["json.j2"] = "jinja2",
          ["cfg.j2"] = "jinja2",
        },
      })
    end,
  },
}
