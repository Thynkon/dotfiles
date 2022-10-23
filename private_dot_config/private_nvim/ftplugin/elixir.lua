require("formatter").setup(
  {
    filetype = {
      elixir = {
        -- rubocop
        function()
          return {
            exe = "mix",
            args = {
              "format",
              "-"
            },
            stdin = true
          }
        end
      }
    }
  }
)

local dap = require("dap")
dap.adapters.mix_task = {
  type = "executable",
  -- command = '/path/to/elixir-ls/debugger.sh', -- debugger.bat for windows
  command = string.format("%s/mason/packages/elixir-ls/debugger.sh", vim.fn.stdpath "data"),
  args = {}
}

dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix test",
    task = "test",
    taskArgs = {"--trace"},
    request = "launch",
    startApps = true, -- for Phoenix projects
    projectDir = "${workspaceFolder}",
    requireFiles = {
      "test/**/test_helper.exs",
      "test/**/*_test.exs"
    }
  }
}

bo.tabstop = 2
bo.shiftwidth = 2
