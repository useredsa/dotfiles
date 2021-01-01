hook global WinSetOption filetype=cf %{
    hook -group ansi buffer BufReadFifo .* %{ eval -draft %sh{
            printf "select %s\n" "$kak_hook_param"
            printf "execute-keys 's\\\\r\\\\n<ret>hd<space>'"
        }
    }
}

hook global WinDisplay .*/cpc/.*\.cpp %{
    define-command cf -override -params .. -docstring %{
        cf [<arguments>]: cf-tool utility wrapper
        All the optional arguments are forwarded to the cf utility
    } %{ eval %sh{
        cd "$(dirname ""$kak_buffile"")"
        output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-cf.XXXXXXXX)/fifo
        discard=$(mktemp -d "${TMPDIR:-/tmp}"/kak-cf.XXXXXXXX)/discard
        mkfifo "${output}"

        command="cf $@"
        ( script -efq -c "$command" ${discard} >${output} & ) >/dev/null 2>&1 </dev/null

        printf %s\\n "evaluate-commands -try-client  '$kak_opt_toolsclient' %{
            edit! -fifo ${output} -scroll *stdin-1024*
            set-option buffer filetype cf
            set-option buffer make_current_error_line 0
            hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
        }"
    }}

    define-command new-test-case -override -docstring %{
        new-test-case: add a new testcase for cf-tool
    } %{ evaluate-commands %sh{
        bufdir="$(dirname ""$kak_buffile"")"
        i=1
        while true; do
            # printf "in$i.txt\n"
            if [ ! -e "$bufdir/in$i.txt" ]; then
                break
            fi
            i=$((i+1))
        done

        printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
            edit! '$bufdir/ans$i.txt'
            edit! '$bufdir/in$i.txt'
        }"
    }}

    define-command import-library -override -params .. -docstring %{
        import-library [<switches>]: Choose a library with rofi and insert it.
        --strip	remove top definitions and main
        --editor	open the selected file
    } %{
        execute-keys "!/home/useredsa/Desktop/cpc/useful_codes/lib_query.sh %arg{@}<ret>"
    }

    bam buffer '<a-;>' <c-w> ': cf test %val{buffile}<ret>' 
    bam buffer '<a-;>' <F1>  ': new-test-case<ret>'         
    bam buffer '<a-;>' <F3>  ': import-library --strip<ret>'
}

