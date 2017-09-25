let g:neoformat_enabled_javascript = ['prettiereslint']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
