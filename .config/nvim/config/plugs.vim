call plug#begin('~/.local/share/nvim/plugged')
" Colorschemes
" """"""""""""

" https://github.com/abra/vim-obsidian
" Obisidan is a colorscheme for Vim
Plug 'abra/vim-obsidian'

" https://github.com/dracula/vim
" :scream: A dark theme for Vim
Plug 'dracula/vim'

" General
" """""""""

" https://github.com/nvim-treesitter/nvim-treesitter
"  Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" https://github.com/bitc/vim-bad-whitespace
" Highlights whitespace at the end of lines, only in modifiable buffers
Plug 'bitc/vim-bad-whitespace'

" https://github.com/akanosora/vimfiles/tree/master/bundle/vim-numbers
" Fork of numbers.vim, a plugin for better line numbers
Plug 'https://github.com/akanosora/vimfiles', { 'rtp': 'bundle/vim-numbers' }

" https://github.com/godlygeek/tabular
" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" https://github.com/airblade/vim-gitgutter
" A Vim plugin which shows a git diff in the gutter (sign column).
Plug 'airblade/vim-gitgutter'

" https://github.com/vim-airline/vim-airline
" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'

" https://github.com/vim-airline/vim-airline-themes
" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" https://github.com/junegunn/fzf.vim
" fzf  vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" https://github.com/tpope/vim-abolish
" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" https://github.com/tpope/vim-fugitive
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" https://github.com/simnalamburt/vim-mundo
" Vim undo tree visualizer
Plug 'simnalamburt/vim-mundo'

" https://github.com/mbbill/undotree
"  The undo history visualizer for VIM
Plug 'mbbill/undotree'

" https://github.com/ap/vim-css-color
" Preview colours in source code while editing
Plug 'ap/vim-css-color'

" https://github.com/neovim/nvim-lspconfig
"  Quickstart configs for Nvim LSP
Plug 'neovim/nvim-lspconfig'

" https://github.com/mfussenegger/nvim-lint
"  An asynchronous linter plugin for Neovim complementary to the built-in
"  Language Server Protocol support.
Plug 'mfussenegger/nvim-lint'

" https://github.com/stevearc/conform.nvim
" Lightweight yet powerful formatter plugin for Neovim
Plug 'stevearc/conform.nvim'

" Completion
" """"""""""

" https://github.com/neoclide/coc.nvim
"  Nodejs extension host for vim & neovim, load extensions like VSCode and host
"  language servers.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language specific
" """""""""""""""""

" Go
" ""

" https://github.com/nsf/gocode
" An autocompletion daemon for the Go programming language
Plug 'nsf/gocode', {'rtp': 'vim'}

" JavaScript
" """"""""""

" https://github.com/1995eaton/vim-better-javascript-completion
" An expansion of Vim's current JavaScript syntax file.
Plug '1995eaton/vim-better-javascript-completion'

" Elixir
" """"""

" https://github.com/elixir-tools/elixir-tools.nvim
"  Neovim plugin for Elixir
" Plug 'nvim-lua/plenary.nvim'
" Plug 'elixir-tools/elixir-tools.nvim'

" imba
" """"

" https://github.com/simeng/vim-imba
" Vimba - Imba syntax highlighting for vim
Plug 'simeng/vim-imba'

call plug#end()
