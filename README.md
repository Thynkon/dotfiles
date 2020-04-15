# dotfiles
The instructions below allow you to have the exact same setup as I do.

## Table of Contents

1. [ZSH](#ZSH)
   1. [oh-my-zsh](#oh-my-zsh)
   1. [Powerlevel10k](#Powerlevel10k)
   1. [Plug-ins](#Plug-ins)
   1. [Screenshot](#Screenshot)

## ZSH
```shell
sudo dnf install zsh
```
### oh-my-zsh
#### Via curl

```shell
ZSH="$HOME/.config/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### Via wget

```shell
ZSH="$HOME/.config/oh-my-zsh" sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
#### Fonts
```shell
sudo dnf install powerline-fonts
```
```shell
kfontinst "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
kfontinst "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
kfontinst "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
kfontinst "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
```

### Powerlevel10k
```shell
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

### Plug-ins
#### alias-tips
```sh
EXPORT ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
```

```sh
$ git clone https://github.com/djui/alias-tips.git $ZSH_CUSTOM/plugins/alias-tips
```

#### zsh-completions
    git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions

#### zsh-syntax-highlighting
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

#### zsh-autosuggestions
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

### Screenshot
![zsh screenshot](private_screenshots/private_zsh.png)
