call plug#begin('~/.local/share/nvim/plugged')
" Colorschemes
" """"""""""""

" https://github.com/abra/vim-obsidian
" Obisidan is a colorscheme for Vim
Plug 'abra/vim-obsidian'

" https://github.com/dracula/vim
" :scream: A dark theme for Vim
Plug 'dracula/vim'

" https://github.com/zanglg/nova.vim
" Another color scheme for vim/neovim, only supports 24bit true color
Plug 'zanglg/nova.vim'

" General
" """""""""

" https://github.com/bitc/vim-bad-whitespace
" Highlights whitespace at the end of lines, only in modifiable buffers
Plug 'bitc/vim-bad-whitespace'

" https://github.com/akanosora/vimfiles/tree/master/bundle/vim-numbers
" Fork of numbers.vim, a plugin for better line numbers
Plug 'https://github.com/akanosora/vimfiles', { 'rtp': 'bundle/vim-numbers' }

" https://github.com/godlygeek/tabular
" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" https://github.com/w0rp/ale
" Asynchronous Lint Engine
Plug 'w0rp/ale'

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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" https://github.com/editorconfig/editorconfig-vim
" EditorConfig plugin
Plug 'editorconfig/editorconfig-vim'

" https://github.com/tpope/vim-abolish
" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" https://github.com/tpope/vim-fugitive
" fugitive.vim: a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Completion
" """"""""""

" https://github.com/Shougo/deoplete.nvim
" Dark powered asynchronous completion framework for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Multiple language plugs
" """""""""""""""""""""""

" https://github.com/sheerun/vim-polyglot
" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" https://github.com/thinca/vim-ref
" Integrated reference viewer.
Plug 'thinca/vim-ref'

" Language specific
" """""""""""""""""

" Go
" ""

" https://github.com/nsf/gocode
" An autocompletion daemon for the Go programming language
Plug 'nsf/gocode', {'rtp': 'vim'}

" https://github.com/zchee/deoplete-go
" deoplete.nvim source for Go
Plug 'zchee/deoplete-go'

" JavaScript
" """"""""""

" https://github.com/carlitux/deoplete-ternjs
" deoplete.nvim source for javascript
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" https://github.com/ternjs/tern_for_vim
" Tern plugin for Vim
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" https://github.com/1995eaton/vim-better-javascript-completion
" An expansion of Vim's current JavaScript syntax file.
Plug '1995eaton/vim-better-javascript-completion'

" https://github.com/ap/vim-css-color
" Preview colours in source code while editing
Plug 'ap/vim-css-color'

" Elixir
" """"""
"
" https://github.com/slashmili/alchemist.vim
" Elixir Integration Into Vim
Plug 'slashmili/alchemist.vim'

call plug#end()
