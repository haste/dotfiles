set -gx PATH "$VOLTA_HOME/bin" $PATH

switch (uname)
  case Linux
    source ~/.asdf/asdf.fish
end

