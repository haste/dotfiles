set -x ANDROID_HOME $HOME/scm/android-sdk-linux
set -x GOROOT $HOME/scm/go
set -x GOPATH $HOME/dev/go

set -x PATH \
  $HOME/usr/bin \
  $HOME/.local/bin \
  $HOME/.cargo/bin \
  $GOROOT/bin \
  $GOPATH/bin \
  $ANDROID_HOME/platform-tools \
  $ANDROID_HOME/tools \
  $PATH
