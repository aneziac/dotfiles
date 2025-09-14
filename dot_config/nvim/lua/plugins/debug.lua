-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F2>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F3>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F4>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'python'
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  
    -- Adapter (debugpy)
    dap.adapters.python = {
      type = 'executable',
      command = vim.fn.exepath('python3') or 'python3',
      args = { '-m', 'debugpy.adapter' },
    }

    -- Portable path helpers (no vim.fs.relative)
    local function norm_abs(p) return vim.fn.fnamemodify(p, ':p') end
    local function dirname(p)  return vim.fs.dirname(p) or vim.fn.fnamemodify(p, ':h') end
    local function isdir(p)    return vim.fn.isdirectory(p) == 1 end

    local function rel_from_root(path, root)
      local PSEP = package.config:sub(1, 1) -- '/' on *nix, '\' on Windows
      path = norm_abs(path)
      root = norm_abs(root)
      if path:sub(1, #root) == root then
        local rel = path:sub(#root + 2) -- skip separator
        return rel:gsub('\\', '/')      -- normalize to forward slashes
      end
      return path:gsub('\\', '/')
    end

    -- Find the project root by common markers
    local function find_root(start_dir)
      local markers = { '.git', 'pyrightconfig.json' }
      local found = vim.fs.find(markers, { upward = true, path = start_dir })[1]
      return found and dirname(found) or vim.fn.getcwd()
    end

    -- Compute cwd/module consistently
    local function py_launch_info()
      local bufpath = vim.api.nvim_buf_get_name(0)
      local bufdir  = dirname(bufpath)
      local root    = find_root(bufdir)

      local rel = rel_from_root(bufpath, root) -- e.g. "src/pkg/mod.py" or "pkg/mod.py"

      local use_src = rel:match('^src/')
      local cwd = use_src and (root .. '/src') or root

      -- Rel path from cwd (so module & cwd align)
      if use_src then rel = rel:gsub('^src/', '') end

      -- Build dotted module
      rel = rel:gsub('%.py$', '')
      rel = rel:gsub('/__init__$', '')      -- package module
      local module = rel:gsub('/', '.')

      return cwd, module
    end

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Python: current file as module (-m)',
        module = function()
          local _, mod = py_launch_info()
          return mod
        end,
        cwd = function()
          local c, _ = py_launch_info()
          return c
        end,
        justMyCode = false,
        console = 'integratedTerminal',
        pythonPath = function()
          local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
          if venv and vim.fn.has('win32') == 0 then
            return venv .. '/bin/python'
          elseif venv then
            return venv .. '\\python.exe'
          end
          return vim.fn.exepath('python3') or 'python3'
        end,
      },
    }

  end,
}
