local present, ts = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

ts.setup {
  endwise = {
    enable = true
  }
}
