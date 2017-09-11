switch (uname)
  case Linux
    if test -z "$DISPLAY" -a (tty) = '/dev/tty1'
      exec xinit -- -bs -core -nolisten tcp vt1
    end
end
