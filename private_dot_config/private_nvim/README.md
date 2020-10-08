# Neovim
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
### Plugins dependencies
COC is a intellisense engine written in Typescript, so, you need to install nodejs.

#### Fedora
```sh
sudo dnf install nodejs
```

#### Archlinux
```sh
sudo pacman install nodejs
```

### vim-plug
```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Open neovim and install all plugins by typing the following:
```sh
:PlugInstall
```

### pynvim
```sh
pip3 install --user pynvim
```

## Features
By using these config files, you will have autocompletion and syntax error checks to the following languages:

| Language(s)           | extension(s)        | dependencies                    |
| ----------------------|---------------------|---------------------------------|
| C/C++                 | coc-clangd          | [clang](https://clang.llvm.org) |
| CSS                   | coc-css             | None                            |
| HTML                  | coc-html, coc-emmet | None                            |
| Javascript/Typescript | coc-tsserver        | None                            |
| JSON                  | coc-json            | None                            |
| PHP                   | coc-phpls           | None                            |
| Python                | coc-python          | None                            |
| SQL                   | coc-sql             | None                            |
| Viml                  | coc-vimlsp          | None                            |
| Rust                  | coc-rls             | [rustup](https://rustup.rs)     |
