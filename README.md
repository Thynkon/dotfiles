# dotfiles
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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### Via wget

```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
#### Fonts
```shell
sudo dnf install powerline-fonts
```

### Powerlevel10k
```shell
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
Set `ZSH_THEME=powerlevel10k/powerlevel10k` in your `~/.zshrc`.

### Plug-ins
#### alias-tips
1. Get it

    Go to your custom plugins folder:

    ```sh
    $ cd ${ZSH_CUSTOM1:-$ZSH/custom}/plugins
    ```

    Then either clone:

    ```sh
    $ git clone https://github.com/djui/alias-tips.git
    ```

    Or download:

    ```sh
    $ wget https://github.com/djui/alias-tips/archive/master.zip
    $ unzip master.zip && mv alias-tips-master alias-tips && rm master.zip
    ```

    Or add it as submodule:

    ```sh
    $ git submodule add https://github.com/djui/alias-tips
    $ git submodule update --init
    ```

2. Include it

    Then add the plugin to your plugin list in oh-my-zsh configuration:

    ```sh
    $ $EDITOR ~/.zshrc

    # -plugins=(...)
    # +plugins=(... alias-tips)
    ```

#### git
https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git

#### zsh-completions
1. Clone the repository inside your oh-my-zsh repo:

        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

2. Enable it in your `.zshrc` by adding it to your plugin list and reloading the completion:

        plugins=(… zsh-completions)
        autoload -U compinit && compinit

#### zsh-syntax-highlighting
1. Clone this repository in oh-my-zsh's plugins directory:

    ```zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```

2. Activate the plugin in `~/.zshrc`:

    ```zsh
    plugins=( [plugins...] zsh-syntax-highlighting)
    ```

3. Restart zsh (such as by opening a new instance of your terminal emulator).

### Screenshot
![zsh screenshot](screenshots/zsh.png)
