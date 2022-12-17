define-command -docstring %{
    Map common greek letters to alt plus letter,
    like α to <a-a>.
} greek-map-letters %{
    map window insert <a-a> α
    # map window insert <a-A>
    map window insert <a-b> β
    # map window insert <a-B>
    map window insert <a-c> χ
    # map window insert <a-C>
    map window insert <a-d> δ
    map window insert <a-D> Δ
    map window insert <a-e> ε
    map window insert <a-E> η # eta instead of capital epsilon
    map window insert <a-f> φ
    map window insert <a-F> Φ
    map window insert <a-g> γ
    map window insert <a-G> Γ
    map window insert <a-h> η
    # map window insert <a-h>
    map window insert <a-i> ι
    map window insert <a-j> θ
    map window insert <a-k> κ
    map window insert <a-K> K
    map window insert <a-l> λ
    map window insert <a-L> Λ
    map window insert <a-m> μ
    map window insert <a-n> ν
    map window insert <a-o> ω
    map window insert <a-O> Ω
    map window insert <a-p> π
    map window insert <a-P> Π
    # map window insert <a-q>
    # map window insert <a-Q>
    map window insert <a-r> ρ
    # map window insert <a-R>
    map window insert <a-s> σ
    map window insert <a-S> Σ
    map window insert <a-t> τ
    map window insert <a-T> θ # theta instead of capital tau
    map window insert <a-u> ʊ
    # map window insert <a-U>
    # map window insert <a-v>
    # map window insert <a-V>
    map window insert <a-w> ω
    map window insert <a-W> Ω
    map window insert <a-x> ξ
    # map window insert <a-X>
    # map window insert <a-y> 
    # map window insert <a-Y>
    map window insert <a-z> ζ
}

define-command -docstring %{
    Map common greek symbols to alt plus symbol,
    like α to <a-a>.
} greek-map-symbols %{
    map window insert <a-lt> ≤
    map window insert <a-gt> ≥
    map window insert <a-=> ≠
    map window insert <c-=> ≈
    map window insert <a-+> ±
    map window insert <a-minus> ∓
    map window insert <a-/> ÷
    map window insert <a-%> ÷
    map window insert <a-]> ∃
    map window insert <a-^> ⋀
}

hook global WinSetOption filetype=(latex|julia) %{
    greek-map-letters
    greek-map-symbols
}

