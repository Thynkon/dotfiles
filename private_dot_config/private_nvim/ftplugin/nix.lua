require('formatter').setup({
  filetype = {
    nix = {
       -- rubocop
       function()
         return {
           exe = "nixpkgs-fmt", -- might prepend `bundle exec `
           args = {},
           stdin = true,
         }
       end
     }
  }
})

bo.tabstop = 2
bo.shiftwidth = 2
