def -override colorscheme-gruvbox-alpha %{
    colorscheme gruvbox-mod
    set-face global PrimarySelection   "%opt{alpha_fg},%opt{alpha_blue}"
    set-face global SecondarySelection "%opt{alpha_fg},%opt{alpha_blue}"
}

def -override colorscheme-gruvbox-transparent %{
    # colorscheme-gruvbox-alpha
    colorscheme gruvbox-mod
    set-face global Default            "%opt{fg}"
    set-face global PrimarySelection   "%opt{alpha_fg},%opt{blue}"
    set-face global SecondarySelection "%opt{alpha_fg},%opt{blue}"
    set-face global StatusLine         "%opt{fg}"
    set-face global BufferPadding      "%opt{bg2}"
}

