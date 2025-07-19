return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
      },
    },
    opts = {
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      -- autoformat = true,
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = false,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        cssls = {},
        html = {},
        rust_analyzer = {},
        tailwindcss = {},
        -- Ensure mason installs the server
        clangd = {
          keys = {
            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
            fallbackFlags = { "-std=c++20" },
          },
        },
        elp = {},
        typst_lsp = {
          settings = {
            exportPdf = "onType", -- Choose onType, onSave or never.
            -- serverPath = "" -- Normally, there is no need to uncomment it.
          },
        },
        asm_lsp = {
          -- root_dir = function(fname)
          --   return require("lspconfig.util").root_pattern(
          --     "Makefile",
          --     "configure.ac",
          --     "configure.in",
          --     "config.h.in",
          --     "meson.build",
          --     "meson_options.txt",
          --     "build.ninja"
          --   )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
          --     fname
          --   ) or require("lspconfig.util").find_git_ancestor(fname)
          -- end,
          -- capabilities = {
          --   offsetEncoding = { "utf-16" },
          -- },
          -- cmd = {
          --   "asm-lsp",
          -- },
          -- init_options = {
          --   usePlaceholders = true,
          --   completeUnimported = true,
          --   clangdFileStatus = true,
          --   fallbackFlags = { "-std=c++20" },
          -- },
        },
      },
    },
  },
}
