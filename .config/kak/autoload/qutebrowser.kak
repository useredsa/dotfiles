# Auto Save for qutebrowser
# ─────────────────────────
hook global BufCreate ".*qutebrowser-editor.*" %{
    hook buffer NormalIdle ".*" 'w'
    hook buffer InsertIdle ".*" 'w'
}


