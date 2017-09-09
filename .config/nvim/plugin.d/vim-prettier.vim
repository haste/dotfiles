let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
let g:prettier#config#print_width = 110

autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync
