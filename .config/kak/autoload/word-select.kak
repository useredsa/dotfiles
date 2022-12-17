# Arguments are commands for direction(1), select-word(2) and select-next-word(3).
# Example: word-select-implementation '<a-:>' 'w' '/'
def word-select-implementation -params 3 -docstring %{
    word-select-implementation <search_key> <movement_key>
} %{
evaluate-commands -save-regs 's' %{
  set-register s %val{selections_desc}
  # Select current word...
  # Catch failures, such as <a-i>w on _*_
  try %{
    execute-keys '<a-i>' %arg{2} %arg{3}
  }
  # ... or another if already selected.
  # (Compare initial and current selections_desc)
  evaluate-commands %sh{
    if test "$kak_selections_desc" = "$kak_reg_s"; then
      printf "execute-keys '%s\\w<ret><a-i>%s%s'\n" "$1" "$2" "$3"
    fi
  }
}
}

define-command word-select-next-word -docstring 'Select word or next word' %{
    word-select-implementation '/' 'w' '<a-:>'
}
define-command word-select-next-big-word -docstring 'Select WORD or next WORD' %{
    word-select-implementation '/' '<a-w>' '<a-:>'
}
define-command word-select-previous-word -docstring 'Select word or previous word' %{
    word-select-implementation '<a-/>' 'w' '<a-;>'
}
define-command word-select-previous-big-word -docstring 'Select WORD or previous WORD' %{
    word-select-implementation '<a-/>' '<a-w>' '<a-;>'
}

map global normal w     '<a-:>: word-select-next-word<ret>'
map global normal W     'E'
map global normal <a-w> '<a-:>: word-select-next-big-word<ret>'
map global normal b     '<a-:><a-;>: word-select-previous-word<ret>'
map global normal <a-b> '<a-:><a-;>: word-select-previous-big-word<ret>'
