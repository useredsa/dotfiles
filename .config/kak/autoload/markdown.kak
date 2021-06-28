hook global BufCreate .*\.(markdown|md|mkd) %{
    set-option buffer filetype markdown
}

