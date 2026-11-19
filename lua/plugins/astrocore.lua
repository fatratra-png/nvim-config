---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        expandtab = true,
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 2,
        clipboard = "unnamedplus",
        undofile = true,
        scrolloff = 8,
        updatetime = 250,
        timeoutlen = 300,
        splitright = true,
        splitbelow = true,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
      },
    },
    mappings = {
      n = {
        ["-"] = { "<CMD>Oil<CR>", desc = "Open parent directory" },
        ["<Leader>cf"] = {
          function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
          desc = "Format buffer",
        },
        ["<Leader>nt"] = { desc = "Tests" },
      },
      v = {
        ["<C-c>"] = { '"+y', desc = "Yank to system clipboard" },
      },
    },
  },
}
