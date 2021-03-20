hook global WinCreate ".*\.tsv" %{
    set window filetype tsv
}

hook global WinSetOption filetype=tsv %{
    set window tabstop 32
}

