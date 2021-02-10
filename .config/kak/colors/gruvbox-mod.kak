# Gruvbox theme for kakoune
# Modified version with support for alpha colors
# Allows for transparent background and alpha selections.

# Color palette
# TODO find origin. There are different gruvbox versions, specify which one it is.
declare-option str gray            "rgb:928374"
declare-option str red             "rgb:fb4934"
declare-option str green           "rgb:b8bb26"
declare-option str yellow          "rgb:fabd2f"
declare-option str blue            "rgb:83a598"
declare-option str purple          "rgb:d3869b"
declare-option str aqua            "rgb:8ec07c"
declare-option str orange          "rgb:fe8019"

declare-option str bg              "rgb:282828"
declare-option str bg1             "rgb:3c3836"
declare-option str bg2             "rgb:504945"
declare-option str bg3             "rgb:665c54"
declare-option str bg4             "rgb:7c6f64"

declare-option str fg0             "rgb:fbf1c7"
declare-option str fg              "rgb:ebdbb2"
declare-option str fg2             "rgb:d5c4a1"
declare-option str fg3             "rgb:bdae93"
declare-option str fg4             "rgb:a89984"

declare-option str alpha_fg        "rgba:ebdbb2af"
declare-option str alpha_blue      "rgba:83a5a86f"
declare-option str alpha_purple    "rgba:a3566baf"

# Reference
# https://github.com/mawww/kakoune/blob/master/colors/default.kak
# For code
set-face global value              "%opt{purple}"
set-face global type               "%opt{yellow}"
set-face global variable           "%opt{blue}"
set-face global module             "%opt{green}"
set-face global function           "%opt{fg}"
set-face global string             "%opt{green}"
set-face global keyword            "%opt{red}"
set-face global operator           "%opt{fg}"
set-face global attribute          "%opt{orange}"
set-face global comment            "%opt{gray}+i"
set-face global documentation      "comment"
set-face global meta               "%opt{aqua}"
set-face global builtin            "%opt{fg}+b"

# For markup
set-face global title              "%opt{green}+b"
set-face global header             "%opt{orange}"
set-face global mono               "%opt{fg4}"
set-face global block              "%opt{aqua}"
set-face global link               "%opt{blue}+u"
set-face global bullet             "%opt{yellow}"
set-face global list               "%opt{fg}"

# Builtin faces
set-face global Default            "%opt{fg},%opt{bg}"
set-face global PrimarySelection   "%opt{fg},%opt{blue}+fg"
set-face global SecondarySelection "%opt{bg},%opt{blue}+fg"
set-face global PrimaryCursor      "%opt{bg},%opt{fg}+fg"
set-face global SecondaryCursor    "%opt{bg},%opt{bg4}+fg"
set-face global PrimaryCursorEol   "%opt{bg},%opt{fg4}+fg"
set-face global SecondaryCursorEol "%opt{bg},%opt{bg2}+fg"
set-face global LineNumbers        "%opt{bg4}"
set-face global LineNumberCursor   "%opt{yellow},%opt{bg1}"
set-face global LineNumbersWrapped "%opt{bg1}"
set-face global MenuForeground     "%opt{bg2},%opt{blue}"
set-face global MenuBackground     "%opt{fg},%opt{bg2}"
set-face global MenuInfo           "%opt{bg}"
set-face global Information        "%opt{bg},%opt{fg}"
set-face global Error              "%opt{bg},%opt{red}"
set-face global StatusLine         "%opt{fg},%opt{bg}"
set-face global StatusLineMode     "%opt{yellow}+b"
set-face global StatusLineInfo     "%opt{purple}"
set-face global StatusLineValue    "%opt{red}"
set-face global StatusCursor       "%opt{bg},%opt{fg}"
set-face global Prompt             "%opt{yellow}"
set-face global MatchingChar       "%opt{fg},%opt{bg3}+b"
set-face global BufferPadding      "%opt{bg2},%opt{bg}"
set-face global Whitespace         "%opt{bg2}+f"

