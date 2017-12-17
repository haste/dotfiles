set -g theme_nerd_fonts yes
set -g theme_display_git yes
set -g theme_color_scheme user

# Based on terminal2
set -l colorfg f8f8f2

set -l pathbg
switch (hostname)
    case midkemia
        set pathbg 44475a
    case '*'
        set pathbg bd93f9
end

set fish_color_autosuggestion 6272a4

set __color_initial_segment_exit     grey red --bold
set __color_initial_segment_su       grey green --bold
set __color_initial_segment_jobs     grey blue --bold

set __color_path                     $pathbg f8f8f2
set __color_path_basename            $pathbg f8f8f2 --bold
set __color_path_nowrite             magenta $colorfg
set __color_path_nowrite_basename    magenta $colorfg --bold

set __color_repo                     green $colorfg
set __color_repo_work_tree           brgrey $colorfg --bold
set __color_repo_dirty               brred $colorfg
set __color_repo_staged              yellow $colorfg

set __color_vi_mode_default          brblue $colorfg --bold
set __color_vi_mode_insert           brgreen $colorfg --bold
set __color_vi_mode_visual           bryellow $colorfg --bold

set __color_vagrant                  brcyan $colorfg
set __color_username                 brgrey f8f8f2
set __color_rvm                      brmagenta $colorfg --bold
set __color_virtualfish              brblue $colorfg --bold
