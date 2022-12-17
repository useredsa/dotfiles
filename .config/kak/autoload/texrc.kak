provide-module latexrc %{

declare-option str texmain 'main.tex'
declare-option str texoutdir 'out'
declare-option str texpdf 'out/main.pdf'
declare-option str texcmd "texfot lualatex --synctex=1 --halt-on-error"

hook global BufCreate .*\.(latex) %{ set-option buffer filetype latex }

declare-option str texmain 'main.tex'
declare-option str texoutdir 'out'
declare-option str texpdf 'out/main.pdf'
declare-option str texcmd "texfot lualatex --synctex=1 --halt-on-error"

define-command maketex -override -docstring "Make LaTex" %{
    nop %sh{ mkdir -p "$kak_opt_texoutdir" }
    try %{
        nop %sh{ bspc node "$kak_opt_replwin#@parent" --ratio 0.6 }
        bspwm-send-text "%opt{texcmd} --output-directory ""%opt{texoutdir}"" ""%opt{texmain}"" && bspc node ""%opt{replwin}#@parent"" --ratio %opt{repl_ratio}"
    } catch %{
        eval -draft make  --output-directory %opt{texoutdir} %opt{texmain}
        echo "Compiling..."
    }
}

define-command goto-pdf -override %{
    $ zathura --synctex-forward "%val{cursor_line}:%val{cursor_column}:%val{bufname}" "%sh{echo ""$kak_opt_texoutdir/$(basename ${kak_opt_texmain%.tex}).pdf""}"
}

define-command texide -override -docstring "open ide windows" %{
    echo %sh{
        /home/useredsa/bspc_u_border_layout.sh --west dolphin --south kitty --east Zathura $kak_client_env_WINDOWID
    }
    $ zathura "%sh{echo ""$kak_opt_texoutdir/${kak_opt_texmain%.tex}.pdf""}"
    dolphin
    @
    nop %sh{
        bspc node --presel-dir cancel
    }
    set window repl_ratio 0.9
}


hook global WinSetOption filetype=(latex|tex) %{
    # hook window BufWritePost .* %{ %sh{ pdflatex header.tex } } # Compile on save
    set-option window makecmd "%opt{texcmd}"
    set-option window texmain %sh{
        if [ -f "$kak_opt_texmain" ]; then
            echo "$kak_opt_texmain";
        elif [ -f "main.tex" ]; then
            echo "main.tex"
        else
            echo "$kak_bufname"
        fi
    }
    set-option window texpdf "%opt{texoutdir}/%sh{printf \%s ${kak_opt_texmain%.tex}.pdf}"
    bam window '<a-;>' <c-w> ': maketex<ret>'
    map global goto p '<esc>: goto-pdf<ret>' -docstring 'PDF'
    alias window ide texide
    set window indentwidth 2
    expandtab
}

}

require-module latexrc
