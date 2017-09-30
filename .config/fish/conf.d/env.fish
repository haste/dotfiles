set -x ANDROID_HOME $HOME/scm/android-sdk-linux
set -x GOROOT $HOME/scm/go
set -x GOPATH $HOME/dev/go

set paths $HOME/usr/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/.fzf/bin $GOROOT/bin $GOPATH/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/tools

for i in $paths
    if test -d $i
        set PATH $i $PATH
    end
end

set -x LC_ALL 'en_US.UTF-8'
set -x LANG 'en_US.UTF-8'

set -x FZF_DEFAULT_COMMAND 'ag -g ""'

switch (uname)
    case Linux
        set -x EDITOR /usr/bin/nvim
end
