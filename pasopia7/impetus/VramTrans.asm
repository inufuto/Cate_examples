ext Chars, Ascii

    cseg

ClearVram:   public ClearVram
    di
        in a,(22h)
        and 3
        or 4
        out (3ch),a
        push af
            ld a,77h
            out (0ch),a
            ld hl,08000h
            ld de,08001h
            ld bc,320/8*200-1
            ld (hl),0
            ldir
        pop af
        and not 4
        out (3ch),a
    ei
ret


TransPattern:    public TransPattern
;   hl:vramAddress
;   de:source
    di
        in a,(22h)
        push af
            ld a,06h
            out (3ch),a

            ld a,11h
            do
                out (0ch),a
                ex af,af'
                    ld b,8
                    do
                        ld a,(de)
                        inc de
                        ld (hl),a
                        inc hl
                    dwnz
                    ld bc,-8
                    add hl,bc
                ex af,af'
                add a,a
            while p | wend
        pop af
        and 3
        out (3ch),a
    ei
ret
