    cseg

WaitSync_:
    public WaitSync_
    push af | push bc
        ld bc, 2000
        do
            dec bc
            ld a,c
            or b
        while nz | wend
        do
            in a,(0e1h)
            and 1
        while z | wend
    pop bc | pop af
ret