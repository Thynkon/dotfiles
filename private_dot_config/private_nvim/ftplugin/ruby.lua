local dap = require("dap")
dap.adapters.ruby = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = {
        "exec",
        "rdbg",
        "-n",
        "--open",
        "--port",
        "${port}",
        "-c",
        "--",
        "bundle",
        "exec",
        config.command,
        config.script
      }
    }
  }
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "debug current file",
    request = "attach",
    localfs = true,
    command = "ruby",
    script = "${file}"
  },
  {
    type = "ruby",
    name = "run current spec file",
    request = "attach",
    localfs = true,
    command = "rspec",
    script = "${file}"
  }
}

bo.tabstop = 2
bo.shiftwidth = 2
