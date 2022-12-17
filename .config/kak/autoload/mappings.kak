# Helper Functions ────────────────────────────────────────────────────────────

define-command bam -params 4.. -docstring %{
    bam <scope> <key> <command> <insert_prefix>:
    BinAry Map in normal and insert mode.
    The given prefix is used before the command in insert mode.
} %{
    map "%arg{1}" normal "%arg{3}" %sh{
        shift 3
        while [ $# -gt 0 ]; do
            printf "%s" "$1"
            shift 1
        done
    }
    map "%arg{1}" insert "%arg{3}" %sh{
        prefix="$2"
        shift 3
        while [ $# -gt 0 ]; do
            printf "%s%s" "$prefix" "$1"
            shift 1
        done
    }
}

define-command home-expansion -hidden -docstring %{
    home-expansion: expand to the begining of
    line/non blank depending on position
} %{
    try %{
        # Keep selections preceeded by whitespace.
        exec -draft %{ '<a-h><a-k>\A\h+.\z<ret>' }
        # If there are any selections left, go to the beginning of the line.
        exec '<a-;>Gh'
    } catch %{
        # Othwerwise, go to the first non-blank.
        exec '<a-;>Gi'
    }
}

define-command select-or-add-cursor -docstring %{
    select a word under cursor, or add cursor on
    next occurrence of current selection
} %{ execute-keys -save-regs '' %sh{
    if [ $(expr $(echo $kak_selection | wc -m) - 1) -eq 1 ]; then
        echo "<a-i>w*"
    else
        echo "*<s-n>"
    fi
}}

# Mappings ───────────────────────────────────────────────────────────────────

hook global KakBegin .* %{

bam global ''      <c-q>    <esc>                         # <c-q> - Closer escape key
bam global '<a-;>' <c-e>    ': e '                        # <c-e> - Edit file
bam global '<a-;>' <c-E>    ': b '                        # <c-E> - Change buffer
bam global '<a-;>' <c-w>    ': db<ret>'                   # <c-w> - Close buffer
bam global '<a-;>' <c-s>    ': w<ret>'                    # <c-s> - Save file
map global normal   '#'     ': comment-line<ret>'         # <#>   - Comment line(s)
map global normal  '<a-#>'  ': comment-block<ret>'        # <a-#> - Comment block(s)
bam global <esc>   <c-d>    ': select-or-add-cursor<ret>' # <c-d> - Auto select equal text
bam global '<a-;>' <home>   ': home-expansion<ret>' ';'
bam global '<a-;>' <s-home> ': home-expansion<ret>'
map global normal    p      <a-p>                         # Switch p and <a-p>
map global normal   <a-p>   p
map global normal   <a-P>   P
map global normal    P      <a-P>
map global normal    ⓘ      <tab>
map global normal    t      <a-i>                         # t        - Trim Object
map global normal  <tab>    )                             # <tab>    - Rotate selections forward
map global normal  <s-tab>  (                             # <s-tab>  - Rotate selections backwards
bam global '<a-;>'   ㉆     ': bn<ret>'                   # <c-tab>  - Rotate selections forward
bam global '<a-;>'   ㋟     ': bp<ret>'                   # <c-s-tab>- Rotate selections backwards
map global view      f      '<a-;><c-i>'                   -docstring "Jump Forward"
map global view      g      '<a-;><c-o>'                   -docstring "Jump Backward"
# map global view      v      'vm<esc>'                      -docstring "Center view"

# Trying out
map global normal f <a-a>
map global normal F <a-i>
map global normal e f
map global normal E F
map global normal <c-left>  <c-o>
map global normal <c-right> <tab>

hook global InsertCompletionShow .* %{ # <tab>/<s-tab> - Loop trhough completion selection
    map window insert <tab>   <c-n>
    map window insert <s-tab> <c-p>
    map window insert <esc>   <c-o>
}
hook global InsertCompletionHide .* %{
    unmap window insert <tab>   <c-n>
    unmap window insert <s-tab> <c-p>
    unmap window insert <esc>   <c-o>
}

# User Mode(s) ────────────────────────────────────────────────────────────────

map global user e ': eval %val{selection}<ret>' -docstring 'Eval sel'
map global user q ': db; q<ret>'                -docstring 'Quit'
map global user r ': send-text<ret>'            -docstring 'To repl'
map global user z <c-s>                         -docstring 'Save sels'
map global user f ': format<ret>'               -docstring 'Format buffer'

}
