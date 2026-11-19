require("config.maven").setup()

-- Autosave (kept from the previous config)
vim.api.nvim_create_autocmd({ "FocusLost", "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" then vim.cmd "silent! write" end
  end,
})
