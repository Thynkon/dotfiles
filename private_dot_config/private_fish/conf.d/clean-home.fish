set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share

## Android
set -x ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -x ANDROID_AVD_HOME "$XDG_DATA_HOME/android"
set -x ANDROID_HOME "$XDG_DATA_HOME/android"
set -x ANDROID_EMULATOR_HOME "$XDG_DATA_HOME/android"
set -x ADB_VENDOR_KEY "$XDG_CONFIG_HOME/android"

## ccache
set -x CCACHE_CONFIGPATH "$XDG_CONFIG_HOME/ccache/ccache.config"
set -x CCACHE_DIR "$XDG_CACHE_HOME/ccache"

## CUDA (NVIDIA's parallel computing architecture and framework)
set -x CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"

# Elixir
# Enable history in IEX through Erlang(OTP)
set -x ERL_AFLAGS "-kernel shell_history enabled"

## GO
set -x GOPATH "$XDG_DATA_HOME/go"

## GnuPG
set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
if not test -d $GNUPGHOME
    mkdir -p $GNUPGHOME
end

## GTK
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

## Java
set -x SDKMAN_DIR "$XDG_DATA_HOME/sdkman"
set -x _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
set -x JAVA_HOME "$HOME/.asdf/shims/java"

set -x GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"

## Javascript
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"

## KDE
set -x KDEHOME "$XDG_CONFIG_HOME/kde"

## MySQL/MariaDB
set -x MYSQL_HISTFILE "$XDG_DATA_HOME/mysql_history"

## neovim
set -x COC_EXTENSIONS_HOME "$XDG_CONFIG_HOME/coc/extensions"

## Perl
set -x PERL_HOME "$HOME/perl5"
set -x PERL5LIB "$PERL_HOME/lib/perl5$PERL5LIB"
set -x PERL_LOCAL_LIB_ROOT "$PERL_HOME$PERL_LOCAL_LIB_ROOT"
set -x PERL_MB_OPT "--install_base \"$PERL_HOME\""
set -x PERL_MM_OPT "INSTALL_BASE=$PERL_HOME"

## Ruby
set -x GEM_HOME "$XDG_DATA_HOME/gem"
set -x GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"
set -x BUNDLE_USER_CONFIG "$XDG_CONFIG_HOME/bundle"
set -x BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundle"
set -x BUNDLE_USER_PLUGIN "$XDG_DATA_HOME/bundle"
set -x SOLARGRAPH_CACHE "$XDG_CACHE_HOME/solargraph"

## Rust
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"

## VS Code
set -x VSCODE_EXTENSIONS "$XDG_DATA_HOME/VSCodium/extensions"

## ZSH
set -x HISTFILE "$XDG_DATA_HOME/zsh/history"
set HISTFILE_DIR (dirname $HISTFILE)
if not test -f $HISTFILE_DIR
    mkdir -p $HISTFILE_DIR
end

set -x STARSHIP_CONFIG "~/.config/starship/config.toml"
set -x FZF_PATH "$XDG_CONFIG_HOME/fzf"
set -x FZF_PREVIEW_ADVANCED true
