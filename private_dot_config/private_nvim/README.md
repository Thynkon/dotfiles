# Neovim
This setup uses neovim's lsp client. Since it's a native client and is written in lua, it provides better performances comparing to CoC.

Since I'm using neovim's lua API, if you want to use my config files you will have to use the latest version of neovim (0.5+).

## Installation
### Fedora
```sh
sudo dnf install neovim
```

### Archlinux
```sh
yay -S neovim-git
```

## Plugins

### [packer](https://github.com/wbthomason/packer.nvim)
```sh
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
```

Open neovim and install all plugins by typing the following:
```sh
:PackerInstall
```

### pynvim
```sh
pip3 install --user pynvim
```

## Features
By using these config files, you will have autocompletion and syntax error checks to the following languages:

| Language(s)           | language server        | dependencies (Archlinux)             |
| ----------------------|---------------------|-----------------------------------------|
| C/C++                 | clangd              | clang                                   |
| CSS                   | cssls               | vscode-css-languageserver-bin (AUR)     |
| GO                    | gopls               | gopls                                   |
| HTML                  | html                | vscode-html-languageserver-bin (AUR)    |
| Javascript/Typescript | denols              | deno                                    |
| JSON                  | jsonls              | vscode-json-languageserver-bin (AUR)    |
| Latex                 | texlab              | texlab                                  |
| Lua                   | sumneko             | lua-language-server (AUR)               |
| PHP                   | intelephense        | nodejs-intelephense (AUR)               |
| Python                | pyls                | python-language-server                  |
| Rust                  | rust-analyzer       | rust-analyzer                           |
| Shell scripting       | bashls              | bash-language-server                    |
| SQL                   | sqlls               | sql-language-server (AUR)               |

### Automation
If you want to automate neovim's setup, you may want to take a look at [a few shell scripts I wrote](https://github.com/Thynkon/archlinux-setup).
