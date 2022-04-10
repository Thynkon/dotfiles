local autocmd = {}

function autocmd.c(events, options)
        vim.api.nvim_create_autocmd(events, {
                pattern = options.pattern,
                callback = options.callback,
                group = options.group,
                command = options.command,
        })
end

function autocmd.g(name, options)
        vim.api.nvim_create_augroup(name, options)
end

return autocmd
