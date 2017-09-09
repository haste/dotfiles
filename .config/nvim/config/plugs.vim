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

" https://github.com/scrooloose/syntastic
" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" https://github.com/airblade/vim-gitgutter
" A Vim plugin which shows a git diff in the gutter (sign column).
Plug 'airblade/vim-gitgutter'

" https://www.wakati.me/help/plugins/vim
" Time tracking
Plug 'wakatime/vim-wakatime'

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

" Completion
" """"""""""

" https://github.com/Shougo/deoplete.nvim
" Dark powered asynchronous completion framework for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Multiple language plugs
" """""""""""""""""""""""

" https://github.com/mustache/vim-mode
" mustache and handlebars mode for vim
Plug 'mustache/vim-mode'

" https://github.com/thinca/vim-ref
" Integrated reference viewer.
Plug 'thinca/vim-ref'

" Language specific
" """""""""""""""""

" Go
" ""

" https://github.com/fatih/vim-go
" Go development plugin for Vim
Plug 'fatih/vim-go', { 'for': 'go' }

" https://github.com/nsf/gocode
" An autocompletion daemon for the Go programming language
Plug 'nsf/gocode', {'rtp': 'vim'}

" https://github.com/zchee/deoplete-go
" deoplete.nvim source for Go
Plug 'zchee/deoplete-go'

" LESS
" """"

" https://github.com/groenewege/vim-less
" vim syntax for LESS (dynamic CSS)
Plug 'groenewege/vim-less'

" JavaScript
" """"""""""

" https://github.com/carlitux/deoplete-ternjs
" deoplete.nvim source for javascript
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" https://github.com/ternjs/tern_for_vim
" Tern plugin for Vim
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" https://github.com/mxw/vim-jsx
" React JSX syntax highlighting and indenting for vim.
Plug 'mxw/vim-jsx'

" https://github.com/othree/yajs.vim
" YAJS.vim: Yet Another JavaScript Syntax for Vim
Plug 'othree/yajs.vim'

" https://github.com/jason0x43/vim-js-indent
" Vim indenter for standalone and embedded JavaScript
Plug 'jason0x43/vim-js-indent'

" https://github.com/othree/es.next.syntax.vim
" ES.Next syntax for Vim
Plug 'othree/es.next.syntax.vim'

" https://github.com/elzr/vim-json
" A better JSON for Vim: distinct highlighting of keywords vs values,
" JSON-specific (non-JS) warnings, quote concealing
Plug 'elzr/vim-json'

" https://github.com/1995eaton/vim-better-javascript-completion
" An expansion of Vim's current JavaScript syntax file.
Plug '1995eaton/vim-better-javascript-completion'

" https://github.com/prettier/vim-prettier
" A vim plugin wrapper for prettier
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }


" https://github.com/hail2u/vim-css3-syntax
" CSS3 syntax (and syntax defined in some foreign specifications) support for
" Vim's built-in syntax/css.vim
Plug 'hail2u/vim-css3-syntax'

" https://github.com/ap/vim-css-color
" Preview colours in source code while editing
Plug 'ap/vim-css-color'

" HTML5

" https://github.com/othree/html5.vim
" HTML5 omnicomplete and syntax
Plug 'othree/html5.vim'

" Python
" """"""

" https://github.com/klen/python-mode
" Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box.
Plug 'klen/python-mode', { 'for': 'python' }

" https://github.com/vim-scripts/indentpython.vim
" An alternative indentation script for python
Plug 'vim-scripts/indentpython.vim'

" Elixir
" """"""
"
" https://github.com/elixir-lang/vim-elixir
" Vim configuration files for Elixir
Plug 'elixir-lang/vim-elixir'

" https://github.com/slashmili/alchemist.vim
" Elixir Integration Into Vim
Plug 'slashmili/alchemist.vim'

" Markdown
" """"""""

" https://github.com/tpope/vim-markdown
" Vim Markdown runtime files
Plug 'tpope/vim-markdown'

" Rust
" """"
"
" https://github.com/rust-lang/rust.vim
" Vim configuration for Rust.
Plug 'rust-lang/rust.vim'

call plug#end()
