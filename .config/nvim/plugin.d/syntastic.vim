autocmd BufNewFile,BufReadPre *.js  let b:syntastic_checkers =
         \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
         \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
         \     ['standard']

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
