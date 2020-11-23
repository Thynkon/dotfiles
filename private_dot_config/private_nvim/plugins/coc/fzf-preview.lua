-- floating window size ratio
vim.g.fzf_preview_floating_window_rate = 0.9

-- fzf command default options
-- vim.g.fzf_preview_default_fzf_options = { '--reverse': v:true, '--preview-window': 'wrap' }

-- Add fzf quit mapping
vim.g.fzf_preview_quit_map = 1

-- jump to the buffers by default, when possible
vim.g.fzf_preview_buffers_jump = 0

-- Commands used for fzf preview.
-- The file name selected by fzf becomes {}
vim.g.fzf_preview_command = 'bat --color=always --plain {-1}'

-- g:fzf_binary_preview_command is executed if this command succeeds, and g:fzf_preview_command is executed if it fails
vim.g.fzf_preview_if_binary_command = '[[ "$(file --mime {})" =~ binary ]]'

-- Commands used for binary file
vim.g.fzf_binary_preview_command = 'echo "{} is a binary file"'

-- Commands used to get the file list from project
vim.g.fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \\!"* *"'

-- Commands used to get the file list from git reposiroty
vim.g.fzf_preview_git_files_command = 'git ls-files --exclude-standard'

-- Commands used to get the file list from current directory
vim.g.fzf_preview_directory_files_command = 'rg --files --hidden --follow --no-messages -g \\!"* *"'

-- Commands used to get the git status file list
vim.g.fzf_preview_git_status_command = "git status --short --untracked-files=all | awk '{if (substr($0,2,1) !~ / /) print $2}'"

-- Commands used for git status preview.
vim.g.fzf_preview_git_status_preview_command =  "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} || " .. "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} || " .. vim.g.fzf_preview_command

-- Commands used for project grep
vim.g.fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=never'

-- MRU and MRW cache directory
vim.g.fzf_preview_cache_directory = string.format('%s/.cache/nvim/fzf_preview', os.getenv("HOME"))

-- If this value is not 0, disable mru and mrw
vim.g.fzf_preview_disable_mru = 0

-- Commands used for current file lines
vim.g.fzf_preview_lines_command = 'bat --color=always --plain --number'

-- Commands used for preview of the grep result
vim.g.fzf_preview_grep_preview_cmd = string.format('%s/node_modules/coc-fzf-preview/bin/preview_fzf_grep', os.getenv('COC_EXTENSIONS_HOME'))

-- Keyboard shortcuts while fzf preview is active
vim.g.fzf_preview_preview_key_bindings = ''
-- let g:fzf_preview_preview_key_bindings = 'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'

-- Specify the color of fzf
vim.g.fzf_preview_fzf_color_option = ''

-- Set the processes when selecting an element with fzf
-- vim.g.fzf_preview_custom_processes = {}
-- For example, set split to ctrl-s
-- let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file')
-- on coc extensions
-- let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file', 'coc')
-- let g:fzf_preview_custom_processes['open-file']['ctrl-s'] = g:fzf_preview_custom_processes['open-file']['ctrl-x']
-- call remove(g:fzf_preview_custom_processes['open-file'], 'ctrl-x')

-- Use as fzf preview-window option
vim.g.fzf_preview_fzf_preview_window_option = ''
-- let g:fzf_preview_fzf_preview_window_option = 'up:30%'

-- Use vim-devicons
vim.g.fzf_preview_use_dev_icons = 1

-- devicons character width
vim.g.fzf_preview_dev_icon_prefix_string_length = 3

-- Devicons can make fzf-preview slow when the number of results is high
-- By default icons are disable when number of results is higher that 5000
vim.g.fzf_preview_dev_icons_limit = 5000

-- The theme used in the bat preview
--FZF_PREVIEW_PREVIEW_BAT_THEME = 'ansi-dark'
