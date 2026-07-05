set -g VIRTUALFISH_VERSION 2.5.1
set -g VIRTUALFISH_PYTHON_EXEC /usr/bin/python3

# Locate virtualfish under whatever Python version has it (path is not version-pinned)
switch (uname)
  case Linux
    for _vf in $HOME/.local/lib/python3.*/site-packages/virtualfish/virtual.fish
      test -f $_vf; and source $_vf; and break
    end
  case Darwin
    for _vf in $HOME/Library/Python/3.*/lib/python/site-packages/virtualfish/virtual.fish
      test -f $_vf; and source $_vf; and break
    end
end
set -e _vf

emit virtualfish_did_setup_plugins
