local key = require("lib/keybindings")

key.map('n', '<F5>', ":w <bar> exec '!cargo run '.shellescape('%')<CR>", { noremap = true })
key.map('n', '<F6>', ":w <bar> exec '!cargo test'<CR>", { noremap = true })
-- autocmd filetype rust nnoremap <F5> :w <bar> exec '!cargo run '.shellescape('%')<CR>
-- autocmd filetype rust nnoremap <F6> :w <bar> exec '!cargo test'<CR>

require('formatter').setup({
  filetype = {
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
  }
})

