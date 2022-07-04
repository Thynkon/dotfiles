local formatter = require("formatter")
local util = require("formatter.util")

formatter.setup(
  {
    filetype = {
      html = {
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath",
              util.escape_path(util.get_current_buffer_file_path())
            },
            stdin = true,
            try_node_modules = true
          }
        end
      }
    }
  }
)
