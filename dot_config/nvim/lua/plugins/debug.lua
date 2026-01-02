vim.pack.add({
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/rcarriga/nvim-dap-ui' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' },
})

local dap = require('dap')
local dapui = require('dapui')

-- Keymaps
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Conditional Breakpoint' })
vim.keymap.set('n', '<F6>', dapui.toggle, { desc = 'Debug UI' })

-- DAP UI
dapui.setup({
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸', play = '▶', step_into = '⏎', step_over = '⏭',
      step_out = '⏮', step_back = 'b', run_last = '▶▶',
      terminate = '⏹', disconnect = '⏏',
    },
  },
})

-- Auto open/close UI
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Breakpoint icons
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
for type, icon in pairs({
  Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘',
  LogPoint = '◆', Stopped = '⭔'
}) do
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define('Dap' .. type, { text = icon, texthl = hl, numhl = hl })
end

-- Adapters
dap.adapters.python = {
  type = 'executable',
  command = 'python3',
  args = { '-m', 'debugpy.adapter' },
}

dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '--interpreter=dap', '--quiet' },
}

-- Helper functions
local function find_root(start_dir)
  local found = vim.fs.find({ '.git', 'pyrightconfig.json' }, { upward = true, path = start_dir })[1]
  return found and vim.fs.dirname(found) or vim.fn.getcwd()
end

local function py_launch_info()  -- For running python as a module
  local bufpath = vim.api.nvim_buf_get_name(0)
  local bufdir = vim.fs.dirname(bufpath)
  local root = find_root(bufdir)

  local rel = vim.fn.fnamemodify(bufpath, ':p'):sub(#vim.fn.fnamemodify(root, ':p') + 2):gsub('\\', '/')
  local use_src = rel:match('^src/')
  local cwd = use_src and (root .. '/src') or root

  if use_src then rel = rel:gsub('^src/', '') end
  rel = rel:gsub('%.py$', ''):gsub('/__init__$', '')
  local module = rel:gsub('/', '.')

  return cwd, module
end

-- Configurations
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Python: current file as module',
    module = function() local _, mod = py_launch_info() return mod end,
    cwd = function() local c, _ = py_launch_info() return c end,
    justMyCode = false,
    console = 'integratedTerminal',
    pythonPath = function()
      local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
      if venv then
        return venv .. (vim.fn.has('win32') == 1 and '\\python.exe' or '/bin/python')
      end
      return 'python3'
    end,
  },
}

dap.configurations.c = {
  {
    type = 'gdb',
    request = 'launch',
    name = 'Debug executable',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
  },
}
dap.configurations.cpp = dap.configurations.c
