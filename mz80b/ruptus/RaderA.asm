include 'Vram.inc'

LeftTop equ Vram + VramRowSize * 12 + 32

VramPointerToRader:
    push de
        ld a,h
        ld h,0
        ld e,l
        ld d,h
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,de ;*5
        add hl,hl ;*10
        add hl,hl ;*20
        add hl,hl ;*40
        srl a
        srl a
        srl a
        ld e,a
        ld d,0
        add hl,de
        ld de,LeftTop
        add hl,de
    pop de
ret


; void DrawFortRader(byte x, byte y, bool visible);
DrawFortRader_: public DrawFortRader_
    push af | push hl | push de | push bc
        ld h,a
        ld l,e
        call VramPointerToRader
        exx
            ld de,0ffc0h ;mask
            ld c,0
        exx
        dec c
        if z
            ld de,0
            ld c,0
        else
            ld de,003fh
            ld c,0
        endif
        and 7
        if nz
            ld b,a
            do
                sla e
                rl d
                rl c
                ld a,e
                or c
                ld e,a
                exx
                    sla e
                    rl d
                    rl c
                    ld a,e
                    or c
                    ld e,a
                exx
            dwnz
        endif
        ld b,6
        do
            ld a,(hl)
            exx
                and e
            exx
            or e
            ld (hl),a
            inc hl
            ld a,(hl)
            exx
                and d
            exx
            or d
            ld (hl),a
            dec hl
            push de
                ld de,VramWidth
                add hl,de
            pop de
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void DrawFighterOnRader()
ext FighterX_, FighterY_
DrawFighterOnRader_: public DrawFighterOnRader_
    push af | push hl | push de | push bc
        ld a,(FighterX_)
        dec a
        ld h,a
        ld c,a
        ld a,(FighterY_)
        dec a
        ld l,a
        call VramPointerToRader

        ld de,0003h
        ld a,c
        ld c,0
        and 7
        if nz
            ld b,a
            do
                sla e
                rl d
                rl c
                ld a,e
                or c
                ld e,a
            dwnz
        endif

        ld b,2
        do
            ld a,(hl)
            xor e
            ld (hl),a
            inc hl
            ld a,(hl)
            xor d
            ld (hl),a
            dec hl
            push de
                ld de,VramWidth
                add hl,de
            pop de
        dwnz
    pop bc | pop de | pop hl | pop af
ret
