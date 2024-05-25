execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/options.vim'
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/keys.vim'
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/plugs.vim'
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/lua/treesitter.lua'
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/lua/elixir-tools.lua'

colorscheme dracula

for plugin in keys(g:plugs)
  let s:plugin_config = $HOME . '/.config/nvim/plugin.d/' . plugin . '.vim'
  if filereadable(s:plugin_config)
    execute 'source ' . s:plugin_config
  endif
endfor
