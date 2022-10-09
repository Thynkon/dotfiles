-- Theme and Styling
g.background = "dark"

if fn.has("termguicolors") == 1 then
  api.nvim_command("set termguicolors")
end

local theme = "nightfox"
local palette = require("nightfox.palette").load("nordfox")

cmd(string.format("colorscheme %s", theme))

require("nightfox").setup({palettes = palette})

--  Show colors in current buffer
require "colorizer".setup(
  {
    "*",
    css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
    html = {names = false} -- Disable parsing "names" like Blue or Gray
  },
  {RRGGBBAA = true}
)

g.spacegray_underline_search = 1
g.spacegray_italicize_comments = 1

-- status line
