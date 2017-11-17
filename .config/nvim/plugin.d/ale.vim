" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['prettier_eslint'],
\}

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'

highlight clear ALEErrorSign
highlight clear ALEWarningSign
