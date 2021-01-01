# Automatic group of changes in insert mode
declare-option -hidden int last_grouping
declare-option int grouping_delay 4
hook global ModeChange ".*:insert" %{
    set buffer last_grouping %sh{ date +%s }
}
# hook global InsertChar "\s" %{ eval %sh{
#     if [ $(($kak_opt_last_grouping + $kak_opt_grouping_delay)) -le $(date +%s) ]; then
#         printf "set buffer last_grouping $(date +%s)\n"
#         printf "exec <c-u>\n"
#     fi
# }}

