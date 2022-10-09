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

bo.tabstop = 2
bo.shiftwidth = 2
