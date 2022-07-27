switch (uname)
  case Linux
    if test -z "$DISPLAY" -a (tty) = '/dev/tty1'
      export SDL_VIDEODRIVER=wayland
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export (dbus-launch)

      switch $hostname
        case triagia
          export GDK_SCALE=2
          exec sway --config ~/.config/sway/triagia

        case '*'
          exec sway
      end
    end
end
