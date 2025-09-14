return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- you must already have this configured
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      show_help = true,
    },
    keys = {
      { "<leader>cop", function() require("CopilotChat").toggle() end, desc = "Copilot Chat Toggle" },
      { "<leader>cq", function() require("CopilotChat").ask("What does this code do?") end, mode = "v", desc = "Copilot Chat: Explain selection" },
    },
  },
}
