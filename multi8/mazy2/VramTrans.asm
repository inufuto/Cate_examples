include "Vram.inc"

ext Chars, Ascii

    cseg

ClearVram:   public ClearVram
    di
        ld a,0eh
        do
            or 30h
            out (2ah),a

            ld hl,8000h
            ld de,8001h
            ld bc,4000h-1
            ld (hl),0
            ldir

            add a,a
            or 1
            and 0fh
            cp 0fh
        while nz | wend
        xor a
        out (2ah),a
    ei
ret


TransPattern:    public TransPattern
;   hl:vramAddress
;   de:source
    di
        ld a,0eh
        do
            or 38h
            out (2ah),a
            ex af,af'
                ld b,8
                do
                    ld a,(de)
                    inc de
                    ld (hl),a
                    inc hl
                    ld a,(de)
                    inc de
                    ld (hl),a
                    dec hl
                    ld a,l
                    add a,VramWidth
                    ld l,a
                    ld a,h
                    adc a,0
                    ld h,a
                dwnz
                ld bc,-VramWidth*CharHeight
                add hl,bc
            ex af,af'
            add a,a
            or 1
            and 7
            cp 7
        while nz | wend
        xor a
        out (2ah),a
    ei
ret


SetWall: public SetWall
    ld de,VramWidth-1
    di
        ld b,CharHeight
        ex af,af'
            ld a,3ah
            out (2ah),a
        ex af,af'
        do
            ld (hl),a | inc hl
            ld (hl),a
            add hl,de
        dwnz
        ex af,af'
            xor a
            out (2ah),a
        ex af,af'
    ei
    ld de,2-VramRowSize
    add hl,de
ret
