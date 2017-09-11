switch (uname)
  case Linux
    alias ls 'ls --color=auto'
  case Darwin
    alias ls 'ls -G'
end

# I like these confirmations.
alias rm 'rm -i'
alias cp 'cp -i'
