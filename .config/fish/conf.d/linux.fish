switch (uname)
  case Linux
    if test -z "$DISPLAY" -a (tty) = '/dev/tty1'
      exec sway
    end
end
