set -g VIRTUALFISH_VERSION 2.5.1
set -g VIRTUALFISH_PYTHON_EXEC /usr/bin/python3

switch (uname)
  case Linux
    source $HOME/.local/lib/python3.9/site-packages/virtualfish/virtual.fish

  case Darwin
    source $HOME/./Library/Python/3.8/lib/python/site-packages/virtualfish/virtual.fish
end

emit virtualfish_did_setup_plugins
