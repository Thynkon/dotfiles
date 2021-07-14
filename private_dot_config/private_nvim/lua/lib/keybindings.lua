local key = {}

function key.map(mode, lhs, rhs, opts)
  local options = {}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

return key
