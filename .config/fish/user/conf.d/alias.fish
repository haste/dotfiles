switch (uname)
  case Linux
    alias ls 'ls --color=auto'
  case Darwin
    alias ls 'ls -G'
end

alias cat 'bat'
alias cal "cal -m"

# I like these confirmations.
alias rm 'rm -i'
alias cp 'cp -i'
