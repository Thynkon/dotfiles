require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "elixir",
    "erlang",
    "eex",
    "heex",
    "go",
    "html",
    "java",
    "json",
    "lua",
    "markdown",
    "nix",
    "php",
    "python",
    "query", -- tsplaygroud
    "ruby",
    "rust",
    "scss",
    "toml"
    --		"perl",  installation fails on nixos
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {} -- list of language that will be disabled
  }
}
