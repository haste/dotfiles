" map escape to unfocus terminal
" Makes using fzf annoying..
" tnoremap <Esc> <C-\><C-n>

" Toggle folds with space
nnoremap <space> za

" Remap split keys
noremap <C-w>u <C-w>k
noremap <C-w>e <C-w>j
noremap <C-w>n <C-w>h
noremap <C-w>i <C-w>l

" Swap ; and ; and save(!) our pinky.
nore ; :
nore : ;

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Always show the sign column. Prevents gitgutter and syntastic from making the
" text jump.
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

function! Colemak()
   noremap <buffer> K U
   noremap <buffer> U K
   noremap <buffer> u k
   noremap <buffer> k u

   noremap <buffer> H N
   noremap <buffer> N H
   noremap <buffer> h n
   noremap <buffer> n h

   noremap <buffer> J E
   noremap <buffer> E J
   noremap <buffer> j e
   noremap <buffer> e j

   noremap <buffer> L I
   noremap <buffer> I L
   noremap <buffer> l i
   noremap <buffer> i l
   "noremap <buffer> l n
endfunction

" Remap keys for colemak and FPS godness.
call Colemak()

noremap K U
noremap U K
noremap u k
noremap k u

noremap H N
noremap N H
noremap h n
noremap n h

noremap J E
noremap E J
noremap j e
noremap e j

noremap L I
noremap I L
noremap l i
noremap i l

