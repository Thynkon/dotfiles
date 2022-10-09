-- require("formatter").setup(
--   {
--     filetype = {
--       heex = {
--         function()
--           return {
--             exe = "mix",
--             args = {
--               "format",
--               "-"
--             },
--             stdin = true
--           }
--         end
--       }
--     }
--   }
-- )

bo.tabstop = 2
bo.shiftwidth = 2
