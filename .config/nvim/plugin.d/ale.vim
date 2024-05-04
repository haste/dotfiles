" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['biome', 'prettier_eslint', 'prettier'],
\   'javascriptreact': ['biome', 'prettier_eslint', 'prettier'],
\   'typescript': ['biome', 'prettier_eslint', 'prettier'],
\   'typescriptreact': ['biome', 'prettier_eslint', 'prettier'],
\   'css': ['prettier'],
\   'go': ['gofmt', 'goimports'],
\   'php': ['phpcbf'],
\   'python': ['black'],
\   'elixir': [],
\}

" Disable Elixir linters as the check for them slows my NUC to a crawl
let g:ale_linters = {
\    'elixir': [],
\   'python': ['ruff'],
\   'javascript': ['biome'],
\   'javascriptreact': ['biome'],
\   'typescript': ['biome'],
\   'typescriptreact': ['biome'],
\}

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'


highlight clear ALEErrorSign
highlight clear ALEWarningSign
