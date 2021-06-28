hook global BufCreate .*\.(latex) %{
    set-option buffer filetype latex
}

define-command maketex -override -docstring "Make LaTex" %{
    try %{
        nop %sh{ bspc node "$kak_opt_replwin#@parent" --ratio 0.6 }
        bspwm-send-text "%opt{makecmd} ""%val{bufname}"" && bspc node ""%opt{replwin}#@parent"" --ratio %opt{repl_ratio}"
    } catch %{
        eval -draft make "%val{bufname}"
        echo "Compiling..."
    }
}

define-command goto-pdf -override %{
    $ zathura --synctex-forward "%val{cursor_line}:%val{cursor_column}:%val{bufname}" "out/%sh{basename $kak_bufname .tex}.pdf"
}

define-command texide -override -docstring "open ide windows" %{
    echo %sh{
        /home/useredsa/bspc_u_border_layout.sh --west dolphin --south kitty --east Zathura $kak_client_env_WINDOWID
    }
    $ zathura "out/%sh{basename $kak_bufname .tex}.pdf"
    dolphin
    @
    nop %sh{
        bspc node --presel-dir cancel
    }
    set window repl_ratio 0.9
}


hook global WinSetOption filetype=(latex|tex) %{
    # hook window BufWritePost .* %{ %sh{ pdflatex header.tex } } # Compile on save
    set-option window makecmd 'texfot lualatex --synctex=1 --halt-on-error --output-directory "out"'
    bam window '<a-;>' <c-w> ': maketex<ret>'
    map global goto p '<esc>: goto-pdf<ret>' -docstring 'PDF'
    alias window ide texide
}
