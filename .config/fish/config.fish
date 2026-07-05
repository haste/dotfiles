# Load my own config, kept separate from fisher-generated files
set -p fish_function_path $__fish_config_dir/user/functions
set -p fish_complete_path $__fish_config_dir/user/completions

for f in $__fish_config_dir/user/conf.d/*.fish
    source $f
end

mise activate fish | source
direnv hook fish | source

# pnpm
set -gx PNPM_HOME "/home/haste/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
