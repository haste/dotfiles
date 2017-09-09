# Dotfiles

Dotfiles based around having a bare Git repository directly in $HOME. No messing
around with symlinking and other madness.

## Getting Started

It's recommended to add a simple `config` alias to simplify maintenance:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

### Prerequisites

The only requirement is Git.

### Installing

```sh
# Clone a bare Git repo into ~/.dotfiles
git clone --bare https://github.com/haste/dotfiles.git $HOME/.dotfiles

# Populate $HOME.
config checkout

# config status gets really messy if this isn't disabled.
config config --local status.showUntrackedFiles no
```

#### Tilix

Tilix is a bit difficult and uses dconf for configurations. This makes it
slightly painful to share the config between computers, but it's at least
possible to dump and load configurations through the dconf cli.

```sh
dconf dump /com/gexperts/Tilix/ > ~/.config/tilix/config.dconf
dconf load /com/gexperts/Tilix/ < ~/.config/tilix/config.dconf
```
