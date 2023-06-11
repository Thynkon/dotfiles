return {{
    "nvim-telescope/telescope.nvim",
    opt = {
        defaults = {
            file_ignore_patterns = { -- JS
            "node_modules", -- PHP
            "vendor", -- Elixir
            "deps", "_build"}
        }
    }
}}
