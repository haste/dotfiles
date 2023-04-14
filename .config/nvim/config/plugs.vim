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

" Completion
" """"""""""

" https://github.com/neoclide/coc.nvim
"  Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" https://github.com/1995eaton/vim-better-javascript-completion
" An expansion of Vim's current JavaScript syntax file.
Plug '1995eaton/vim-better-javascript-completion'

" https://github.com/ap/vim-css-color
" Preview colours in source code while editing
Plug 'ap/vim-css-color'

" Elixir
" """"""

"  Elixir language server extension based on elixir-ls for coc.nvim
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" imba
" """"

" https://github.com/simeng/vim-imba
" Vimba - Imba syntax highlighting for vim
Plug 'simeng/vim-imba'

call plug#end()
