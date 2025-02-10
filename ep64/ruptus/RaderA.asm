include "Vram.inc"

ext FighterX_, FighterY_

RaderTop equ 12
RaderLeft equ 32
RaderWidth equ 8
RaderHeight equ 12
RaderVram equ Vram+VramRowSize*RaderTop+RaderLeft*VramStep
VramStep equ 2

; void PrintRader();
cseg
PrintRader_: public PrintRader_
    push af | push hl | push de| push bc
        ld hl,RaderVram
        ld de,VramWidth-RaderWidth*VramStep
        ld c,RaderHeight*CharHeight
        do
            ld b,RaderWidth*VramStep
            do
                ld (hl),33h
                inc hl
            dwnz
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


RowAddressHl:
    ld d,0
    ld l,e | ld h,d
    add hl,hl ;*2
    add hl,hl ;*4
    add hl,de ;*5
    add hl,hl ;*10
    add hl,hl ;*20
    add hl,hl ;*40
    add hl,hl ;*80
    ld de,RaderVram
    add hl,de
ret


; void DrawFortRader(byte x, byte y, bool visible);
cseg
DrawFortRader_: public DrawFortRader_
    push af | push hl | push de | push bc
        ld b,c
        rra | rra | and 0fh
        ld c,a

        call RowAddressHl
        ld d,b
        ld b,0
        add hl,bc

        ld a,d
        or a
        if nz
            ld de,3b3fh
        else
            ld de,3333h
        endif
        
        ld b,6
        do
            ld (hl),e
            inc hl
            ld (hl),d
            push de
                ld de,VramWidth-1
                add hl,de
            pop de
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void DrawFighterOnRader()
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    push af | push hl | push de | push bc
        ld a,(FighterY_)
        dec a
        ld e,a
        and 0feh
        call RowAddressHl

        ld a,(FighterX_)
        dec a
        rra | ld d,a
        rra | and 0fh
        ld c,a | ld b,0
        add hl,bc

        ld a,d
        and 1
        if z
            ld c,88h
        else
            ld c,44h
        endif
        
        ld de,VramWidth
        ld b,2
        do
            ld a,(hl)
            xor c
            ld (hl),a
            add hl,de
        dwnz
    pop bc | pop de | pop hl | pop af
ret
