# Helper Functions ────────────────────────────────────────────────────────────

define-command bam -params 4 -docstring %{
    bam <scope> <key> <command> <insert_prefix>:
    BinAry Map in normal and insert mode.
    The given prefix is used before the command in insert mode.
} %{
    map "%arg{1}" normal "%arg{3}" "%arg{4}"
    map "%arg{1}" insert "%arg{3}" "%arg{2}%arg{4}"
}

define-command home-expansion -hidden -docstring %{
    home-expansion: expand to the begining of
    line/non blank depending on position
} %{
    eval -itersel %{ # Run each selection independently so that the
        try %{       # test does not just remove failing selections.
            # Check that the preceeding characters are horizontal whitespaces.
            exec -draft %{ <a-h><a-k>\A\h+.\z<ret> }
            exec Gh # If the previous line does not fail, go to begining of line.
        } catch %{  # Othwerwise, go to first non blank character
            exec Gi
        }
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
map global normal  <home>   ': home-expansion<ret>;'
map global insert  <home>   '<esc>: home-expansion<ret>;i'
bam global <esc>   <s-home> ': home-expansion<ret>'
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

}
