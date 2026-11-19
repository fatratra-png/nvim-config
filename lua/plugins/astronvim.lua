---@type LazySpec
return {
  -- Last fragment wins in lazy.nvim: this is what points the core at your fork.
  -- GitHub forks do not carry tags, so there is no `version` pin.
  {
    "AstroNvim/AstroNvim",
    url = "https://github.com/fatratra-png/astronvim-config.git",
  },
}
