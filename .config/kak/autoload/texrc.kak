provide-module latexrc %{

define-command maketex -override -docstring "Make LaTex" %{
    nop %sh{ bspc node "$kak_opt_replwin#@parent" --ratio 0.6 }
    try %{
        bspwm-send-text "%opt{makecmd} ""%val{bufname}"" && bspc node ""%opt{replwin}#@parent"" --ratio %opt{repl_ratio}"
    } catch %{
        make "%val{bufname}"
    }
}

define-command goto-pdf -override %{
    $ zathura --synctex-forward "%val{cursor_line}:%val{cursor_column}:%val{bufname}" "out/%sh{basename $kak_bufname .tex}.pdf"
}

hook global WinSetOption filetype=(latex|tex) %{
    # hook window BufWritePost .* %{ %sh{ pdflatex header.tex } } # Compile on save
    set-option window makecmd 'texfot lualatex --synctex=1 --halt-on-error --output-directory "out"'
    bam window '<a-;>' <c-w> ': maketex<ret>'
    map global goto p '<esc>: goto-pdf<ret>' -docstring 'PDF'
}

}

require-module latexrc
