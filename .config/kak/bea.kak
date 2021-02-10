# Algunas cosillas que considero interesantes.
# Muchos comandos pone -docstring y ahí pone lo que hace.
# Otros puedes buscar lo que hacen con el comando doc
# (por ejemplo `doc options` para ver qué hacen las opciones y buscar con `/`)
# o entender la sintaxis escribiendo poco a poco el comando en la línea
# y viendo el menú de ayuda.

# Para poder editar tu fichero de configuración rápidamente
def config -docstring %{ config: Edit kakrc } %{ edit ~/.config/kak/kakrc }

# Basic Configuration ─────────────────────────────────────────────────────────

set global startup_info_version 20201901 # Only show update messages post v2020.08.04
set global scrolloff 1,5
set global tabstop 4
set global grepcmd 'rg --with-filename --column'

# Algún colorscheme que te guste (te puedes bajar alguno también)
colorscheme gruvbox

# Mira lo que hace cada highlighter. Al menos el de numerar las líneas lo pondría.
add-highlighter global/ show-matching
add-highlighter global/ number-lines
add-highlighter global/ regex '(\b|%|//|#)? ?(TODO|FIXME|XXX|NOTE)\b' 0:default+rb
# Este highlighter es para hacer pasar partir las líneas si superan cierta longitud
# Este me creo un comando que lo llama para poder cambiar la anchura máxima según el tipo de fichero
define-command wraphl -params 1 %{
    add-highlighter -override window/wrap wrap -indent -marker … -width %arg{1}
}

hook global WinSetOption filetype=(c|cpp|latex|markdown) %{
    wraphl 120
}

# Plugins ─────────────────────────────────────────────────────────────────────

# Ya tienes la base para poder poner plugins

plug terminal-mode "https://github.com/alexherbo2/terminal-mode.kak" %{
    map global user t ': enter-user-mode terminal<ret>' -docstring 'Terminal mode'
    require-module x11
    set global termcmd 'kitty sh -c'
}

# Éste hace que al escribir una un caracter se te ponga la pareja automáticamente si quieres
plug auto-pairs "https://github.com/alexherbo2/auto-pairs.kak" %[
    set-option global auto_pairs ( ) { }
]

# MUY NECESARIO
# Éste para decidir si pones tabulador cuando pulses tab o sustituirlo por espacios
# Yo por ejemplo tengo puesto en casi todos sitios que el tabulador inserte 4 espacios,
# pero en un Makefile por ej tienes que usar tabuladores ogligatoriamente y ahí tengo noexpandtab
# smarttab es otra opción que elige una u otra según el contenido del archivo (si ya tiene tabs o espacios)
plug smarttab "https://github.com/andreyorst/smarttab.kak" %{
    set global softtabstop 4
    hook global WinSetOption filetype=(c|cpp|asciidoctor|rust|markdown|kak|sh|perl|julia|latex|java) expandtab
    hook global WinSetOption filetype=(makefile|gas) noexpandtab
    hook global WinSetOption filetype=() smarttab
}

# MUY NECESARIO
# Para sincronizar el portapepeles de kakoune con lo de fuera.
# Depende de que tengas instalado xsel o xclip. Ambos son programillas muy ligeros.
# Si no sabes cuál elegir pilla xsel.
plug-old kakboard "https://github.com/lePerdu/kakboard" %{
    hook global WinCreate .* %{ kakboard-enable }
    # hook global WinDisplay .* %{ set window kakboard_copy_cmd "base64 | (printf '\033]52;c;!\033\a\033]52;c;'; cat; printf '\a') >""%val{client_env_TTY}""" }
}

# Este plugin me gusta. Sirve para hacer selecciones fantasma que se vean.
# Vamos, que seleccionas algo y pulsas <c-g> (en mi caso) y guardas la selección
# y la puedes recuperar con <c-g>. Tanto en insert como en normal mode.
# Es similar a los botones Z y z que ya vienen con kakoune
plug-old kakoune-phantom-selection "https://github.com/occivink/kakoune-phantom-selection" %{
    # face global PhantomSelection "default,rgba:72637216+g"
    face global PhantomSelection "%opt{alpha_fg},%opt{alpha_purple}"
    define-command -docstring %{
        phantom-group: Creates a phantom group of selections
    } -hidden phantom-group %{
        phantom-selection-add-selection
        map buffer normal <tab>   ': phantom-selection-iterate-next<ret>'
        map buffer insert <tab>   '<esc>: phantom-selection-iterate-next<ret>i'
        map buffer normal <s-tab> ': phantom-selection-iterate-prev<ret>'
        map buffer insert <s-tab> '<esc>: phantom-selection-iterate-prev<ret>i'
        map buffer normal <c-g>   ': phantom-ungroup<ret>'
        map buffer insert <c-g>   '<esc>: phantom-ungroup<ret>i'
    }
    define-command -docstring %{
        phantom-ungroup: Removes a phantom group of selections
    } -hidden phantom-ungroup %{
        phantom-selection-select-all
        phantom-selection-clear
        unmap buffer normal <tab>   ': phantom-selection-iterate-next<ret>'
          map buffer insert <tab>   '<tab>'
        unmap buffer normal <s-tab> ': phantom-selection-iterate-prev<ret>'
        unmap buffer insert <s-tab> '<esc>: phantom-selection-iterate-prev<ret>i'
        unmap buffer normal <c-g>   ': phantom-ungroup<ret>'
        unmap buffer insert <c-g>   '<esc>: phantom-ungroup<ret>i'
    }
    map global normal <c-g> ': phantom-group<ret><space>'
    map global insert <c-g> '<a-;>: phantom-group<ret><a-;><space>'
}

# Local kakrc ─────────────────────────────────────────────────────────────────

# Para tener un kakrc local como te dije

hook global BufCreate (.*/)?(\.kakrc\.local) %{
    set-option buffer filetype kak
}

try %{ source .kakrc.local }

# Mappings ────────────────────────────────────────────────────────────────────

# los que quieras poner
# los que yo te pongo me parecen muy importantes

# Para cuando te salen un desplegable para completar la palabra en modo insert,
# cambiar de opción con <tab> y <s-tab> y no con <c-p> y <c-n>
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

# Para evaluar (como si las metieses en la línea que abres con :) lo que tengas seleccionado
map global user e ': eval %val{selection}<ret>' -docstring 'Eval sel'

# para salir de kakoune pulsando ,q en vez de :q<ret> (me parece más cómodo)
map global user q ': q<ret>'                -docstring 'Quit'

# Ejercicio: ponerte un shortcut para compilar el fichero latex actual automáticamente
# Una posible solución pasa por cambiar el valor de la opción `makecmd` que se usa en el comando make
# en esas ventanas


