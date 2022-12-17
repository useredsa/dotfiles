hook global WinSetOption filetype=(c|cpp) %{
  set window formatcmd 'clang-format --style=file --fallback-style=Google'
  set window softtabstop 2
  set window indentwidth 2
}
