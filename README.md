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
