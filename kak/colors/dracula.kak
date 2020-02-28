evaluate-commands %sh{

black=rgb:282a36
gray=rgb:44475a
white=rgb:f8f8f2
blue=rgb:6272a4
cyan=rgb:8be9fd
green=rgb:50fa7b
orange=rgb:ffb86c
pink=rgb:ff79c6
purple=rgb:bd93f9
red=rgb:ff5555
yellow=rgb:f1fa8c

echo "
# Code
set-face global value $green
set-face global type $purple
set-face global variable $red
set-face global module $red
set-face global function $red
set-face global string $yellow
set-face global keyword $cyan
set-face global operator $orange
set-face global attribute $pink
set-face global comment $blue+i
set-face global meta $red
set-face global builtin $white+b

# Markup
set-face global title $red
set-face global header $orange
set-face global bold $pink
set-face global italic $purple
set-face global mono $green
set-face global block $cyan
set-face global link $green
set-face global bullet $green
set-face global list $white

# Built-in
set-face global Default $white,$black
set-face global PrimarySelection $black,$pink+fg
set-face global SecondarySelection $black,$purple+fg
set-face global PrimaryCursor $black,$cyan+fg
set-face global SecondaryCursor $black,$orange+fg
set-face global PrimaryCursorEol $black,$cyan+fg
set-face global SecondaryCursorEol $black,$orange+fg
set-face global LineNumbers $gray,$black
set-face global LineNumberCursor $white,$gray+b
set-face global LineNumbersWrapped $gray,$black+i
set-face global MenuForeground $blue,$white+b
set-face global MenuBackground $white,$blue
set-face global MenuInfo $cyan,$blue
set-face global Information $yellow,$gray
set-face global Error $black,$red
set-face global StatusLine $white,$black
set-face global StatusLineMode $black,$green
set-face global StatusLineInfo $purple,$black
set-face global StatusLineValue $orange,$black
set-face global StatusCursor $white,$blue
set-face global Prompt $black,$green
set-face global MatchingChar $black,$blue
set-face global BufferPadding $gray,$black
set-face global Whitespace $gray,$black
"

}
