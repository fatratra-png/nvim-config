---@type LazySpec
return {
  -- Oil: edit a directory buffer with `-`, alongside neo-tree
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      keymaps = { ["<C-h>"] = false, ["<C-l>"] = false },
      view_options = { show_hidden = true },
    },
  },

  { "github/copilot.vim", event = "VeryLazy" },

  -- Java test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcasia/neotest-java",
    },
    keys = {
      { "<leader>ntr", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>ntf", function() require("neotest").run.run(vim.fn.expand "%:p") end, desc = "Run file tests" },
      { "<leader>ntl", function() require("neotest").run.run_last() end, desc = "Run last test" },
      { "<leader>nts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>nto", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output" },
    },
    opts = function()
      return {
        adapters = {
          require "neotest-java" {
            disable_update_notifications = true,
            test_classname_patterns = { "^.*Tests?$", "^.*IT$", "^.*Spec$", "^Test.*$" },
          },
        },
        status = { virtual_text = true },
        output = { open_on_run = "short" },
      }
    end,
  },

  -- Explorateur ouvert au démarrage, comme VS Code
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function() vim.cmd "Neotree show" end,
      })
    end,
  },
}
