cseg

ClearVram: public ClearVram
    di
        ld c,5ch
        do
            out (c),a
            push bc
                ld hl,08000h
                ld de,08001h
                ld bc,4000h-1
                ld (hl),0
                ldir
            pop bc
            inc c
            ld a,c
            cp 5fh
        while nz | wend
        out (5fh),a
    ei
ret


WriteVram: public WriteVram
    ld c,5ch
    do
        push hl
            out (c),a
            ld b,8
            do
                ld a,(de)
                ;ld a,055h
                inc de
                ld (hl),a
                push bc
                    ld bc,40
                    add hl,bc
                pop bc
            dwnz
        pop hl
        inc c
        ld a,c
        cp 5fh
    while nz | wend
    out (5fh),a
ret
