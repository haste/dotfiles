" 24-bit colors
set termguicolors

" Required by Vundle
filetype off

" Don't create swapfiles
set noswapfile

" Display title
set title

" Enable smart indenting
set smartindent

" persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Tabbing
set complete=.,w,b,u,U,t,i,d
set completeopt-=preview
set tabstop=2 " <Tab> == two spaces
set softtabstop=0
set expandtab
set shiftwidth=2 " The number" of spaces to use for indenting.

" And normal numbers
set number
" Relative line numbers, can't live without them!
set relativenumber
" Support modelines
set modeline
" Don't wrap long lines
set nowrap
" Keep 10 lines on the screen
set scrolloff=10
" Show invisible characters
set list
set list listchars=tab:\|\ ,trail:·

" Add highlight at 80 and 110 chars
set colorcolumn=80,110

" Don't close buffer when opening new files.
set hidden

" Color the entire line the cursor is on
set cursorline

" Always show the sign column. Prevents gitgutter and syntastic from making the
" text jump.
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Save history
augroup nvimrc_aucmd
  autocmd!
  autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
augroup END
