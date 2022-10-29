local present, ts = pcall(require, "telescope")

if not present then
  return
end

ts.setup {
  defaults = {
    file_ignore_patterns = {
      -- JS
      "node_modules",
      -- PHP
      "vendor",
      -- Elixir
      "deps",
      "_build"
    }
  }
}
