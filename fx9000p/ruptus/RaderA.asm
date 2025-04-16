include "Vram.inc"
include "VVram.inc"

RaderLeftTop equ Vram+VramRowSize*8+VVramWidth*VramStep
ext FighterX_,FighterY_ 

; void PrintRader();
cseg
PrintRader_: public PrintRader_
    push af | push hl | push de | push bc
        ld hl,RaderLeftTop
        ld de,VramRowSize+CharHeight*6
        ld c,8
        do
            ld b,CharHeight*6
            do
                ld (hl),0ffh | dec hl
            dwnz
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawFortOnRader(byte x, byte y, bool visible)
cseg
DrawFortOnRader_: public DrawFortOnRader_
    push af | push hl | push de | push bc
        ld b,a ; x
            ld a,e
            rrca | rrca | rrca | and 0fh
            add a,8
            neg
            ld d,a | ld e,0
            ld hl,Vram
            add hl,de
        ld a,b ; x
        and 0f8h
        add a,VVramWidth*CharHeight
        neg
        ld e,a | ld d,0ffh
        add hl,de

        ld a,c
        or a
        if nz
            LD c,03h
        else
            LD c,0ffh
        endif
        ld b,6
        do
            ld (hl),c | dec hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void DrawFighterOnRader();
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    push af | push hl | push de | push bc
        ld a,(FighterY_)
        dec a
        and 3eh
        cp 64
        if nc
            xor a
        endif
        add a,CharHeight*8
        ld c,a ;y

        ld a,(FighterX_)
        dec a
        and 3eh
        cp 48
        if nc
            xor a
        endif
        add a,VVramWidth*8
        ld b,a

        ld a,c
        dec a
        rrca | rrca | rrca | and 0fh
        neg
        ld d,a | ld e,0
        ld hl,Vram
        add hl,de
        ld a,b
        and 0f8h
        neg
        ld e,a | ld d,0ffh
        add hl,de

                                _deb: public _deb
        ld a,c
        and 7 | neg
        ld e,a | ld d,0ffh
        add hl,de

        ld c,0c0h
        ld a,b
        rrca
        and 3
        do | while nz
            srl c | srl c
            dec a
        wend

        ld b,2
        do
            ld a,(hl)
            xor c
            ld (hl),a | dec hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret
