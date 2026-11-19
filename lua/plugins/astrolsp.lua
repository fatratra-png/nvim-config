---@type LazySpec
return {
  -- Load the LSP layer before the first file so `vim.lsp.enable` is not missed
  { "AstroNvim/astrolsp", lazy = false },
  { "neovim/nvim-lspconfig", lazy = false },
  { "mason-org/mason-lspconfig.nvim", lazy = false },

  {
    "AstroNvim/astrolsp",
    opts = {
      -- Keep one Python language server (basedpyright)
      handlers = {
        pyrefly = false,
        ruff = false,
        ty = false,
      },
      config = {
        -- Bundled Kotlin compiler 2.1 cannot parse Java 25
        kotlin_language_server = {
          cmd = { "env", "JAVA_HOME=/home/fatratra/.jdks/ms-21.0.11", "kotlin-language-server" },
          -- nvim-lspconfig sets storagePath only when a Gradle/Maven root exists;
          -- an empty table is sent as `[]` and crashes the server
          init_options = { storagePath = vim.fn.stdpath "cache" .. "/kotlin-language-server" },
        },
      },
    },
  },
}
