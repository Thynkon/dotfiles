-- Theme and Styling 
vim.g.background = "dark"

if vim.fn.has('termguicolors') == 1 then
  vim.api.nvim_command("set termguicolors")
end

vim.cmd("colorscheme onedark")

--  Show colors in current buffer
require 'colorizer'.setup ({
  '*';
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
},{RRGGBBAA = true})

vim.g.spacegray_underline_search = 1
vim.g.spacegray_italicize_comments = 1

-- status line
local lualine = require('lualine')

lualine.theme = "onedark"
