set -x ANDROID_HOME $HOME/opt/android-sdk
set -x GOPATH $HOME/dev/go

set fish_user_paths $GOROOT/bin $GOPATH/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $HOME/.local/bin $HOME/.yarn/bin /var/lib/snapd/snap/bin $HOME/bin $HOME/.cargo/bin

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'

set -x FZF_DEFAULT_COMMAND 'ag -g ""'

set -x BAT_THEME 'Dracula'

set -x LESS "-XFR"

switch (uname)
    case Linux
        set -x EDITOR /usr/bin/nvim

    case Darwin
        set fish_user_paths /opt/homebrew/bin $fish_user_paths

end
