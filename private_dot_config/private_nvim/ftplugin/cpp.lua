local key = require("lib/keybindings")

require('formatter').setup({
  filetype = {
    cpp = {
        -- clang-format
       function()
          return {
            exe = "clang-format",
            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
          }
        end
    },
  }
})


key.map('n', '<F5>', ":w <bar> exec '!make'<CR>", { noremap = true })
