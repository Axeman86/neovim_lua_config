-- formatting configuration
return {
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cc = { "clang_format" },
        cpp = { "clang_format" },
        h = { "clang_format" },
        hh = { "clang_format" },
        hpp = { "clang_format" },
      },
      formatters = {
        clang_format = {
          command = vim.fn.stdpath("data") .. "/mason/bin/clang-format", -- version 15.0.6
        },
      },
    },
  },
}
