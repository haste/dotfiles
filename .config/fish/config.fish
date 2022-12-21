set -gx PATH "$VOLTA_HOME/bin" $PATH

switch (uname)
  case Linux
    source ~/.asdf/asdf.fish
  case Darwin
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

