# Neovim
## Installation
```sh
sudo dnf install neovim
```

## Plugins
### Plugins dependencies
COC is a intellisense engine written in Typescript, so, you need to install nodejs.

```sh
sudo dnf install nodejs
```

coc-lua, a lua extension, needs luarocks (lua package manager) and some lua development files.

```sh
sudo dnf install luarocks lua-devel
```

coc-rls, a rust extension, uses rustup. Fedora does not ship rustup, so you have to install it manually.

```sh
curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
```
This script will install rust tools non-interactively and without modifying your dotfiles (.bashrc or .zshrc).

### vim-plug
```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Open neovim and install all plugins by typing the following:
```sh
PlugInstall
```

### pynvim
```sh
pip3 install --user pynvim
```

## Features
By using these config files, you will have autocompletion and syntax error checks to the following languages:

| Language(s)           | extension(s)        |
| ----------------------|---------------------|
| C/C++                 | coc-clangd          |
| CSS                   | coc-css             |
| HTML                  | coc-html, coc-emmet |
| Javascript/Typescript | coc-tsserver        |
| JSON                  | coc-json            |
| Lua                   | coc-lua             |
| JSON                  | coc-json            |
| PHP                   | coc-phpls           |
| Python                | coc-python          |
| SQL                   | coc-sql             |
| Viml                  | coc-vimlsp          |
| Rust                  | coc-rls             |
