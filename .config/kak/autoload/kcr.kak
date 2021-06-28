map global normal <c-t> ': new<ret>'               -docstring 'New client'
map global normal <c-n> ': connect-terminal<ret>'  -docstring 'New terminal'
map global normal   +   ': connect-popup<ret>'     -docstring 'New popup'
map global normal <c-o> ': $ dolphin .<ret>'       -docstring 'Open Dolphin'
map global normal <c-e> ': > broot<ret>'           -docstring 'Open Broot'
map global normal <c-f> ': + kcr-fzf-files<ret>'   -docstring 'Open files'
map global normal <c-b> ': + kcr-fzf-buffers<ret>' -docstring 'Open buffers'
map global normal <c-g> ': + kcr-fzf-grep<ret>'    -docstring 'Open files by content'
map global normal <c-l> ': + gitui<ret>'           -docstring 'Open gitui'

evaluate-commands %sh{
    kcr init kakoune
}

hook -once global ModuleLoaded kitty %{
    alias global popup kitty-terminal-tab
}
hook -once global ModuleLoaded bspwm-repl %{
    alias global repl-new bspwm-repl
}

