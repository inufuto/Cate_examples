cseg

ClearVram: public ClearVram
    di
        out (5ch),a
        ld hl,08000h
        ld de,08001h
        ld bc,4000h-1
        ld (hl),0
        ldir
        out (5fh),a
    ei
ret


WriteVram: public WriteVram
    out (5ch),a
    ld b,8
    do
        ld a,(de)
        inc de
        ld (hl),a
        inc hl
        ld a,(de)
        inc de
        ld (hl),a
        push bc
            ld bc,80-1
            add hl,bc
        pop bc
    dwnz
    out (5fh),a
ret
