set -x ANDROID_HOME $HOME/opt/android-sdk
set -x GOPATH $HOME/dev/go

set paths $HOME/usr/bin $HOME/.local/bin $HOME/.cargo/bin $GOROOT/bin $GOPATH/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $HOME/.yarn/bin

for i in $paths
    if test -d $i
        set -U fish_user_paths $i $fish_user_paths
    end
end

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'

set -x FZF_DEFAULT_COMMAND 'ag -g ""'

switch (uname)
    case Linux
        set -x EDITOR /usr/bin/nvim
end
