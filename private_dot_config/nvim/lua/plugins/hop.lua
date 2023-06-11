return {{
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    keys = {{
        "<leader><leader>w",
        function()
            require("hop").hint_words()
        end,
        desc = "Jump to the beggining of words"
    }, {
        "<leader><leader>l",
        function()
            require("hop").hint_lines()
        end,
        desc = "Jump to the beggining of lines"
    }, {
        "<leader><leader>p",
        function()
            require("hop").hint_patterns()
        end,
        desc = "Jump to a pattern (similar to /)"
    }},
    opts = {
        keys = "etovxqpdygfblzhckisuran"
    },
    vscode = true
}}
