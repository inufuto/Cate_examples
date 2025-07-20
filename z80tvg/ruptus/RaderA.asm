include "Vram.inc"
include "Chars.inc"

ext FighterX_, FighterY_
ext Vram_

VramRowSize equ VramWidth
VramStep equ 1

RaderTop equ 12
RaderLeft equ 32
RaderWidth equ 8
RaderHeight equ 12
RaderVram equ Vram_+VramRowSize*RaderTop+RaderLeft*VramStep

cseg
YTable:
    defw RaderVram+VramRowSize*0
    defw RaderVram+VramRowSize*1
    defw RaderVram+VramRowSize*2
    defw RaderVram+VramRowSize*3
    defw RaderVram+VramRowSize*4
    defw RaderVram+VramRowSize*5
    defw RaderVram+VramRowSize*6
    defw RaderVram+VramRowSize*7
    defw RaderVram+VramRowSize*8
    defw RaderVram+VramRowSize*9
    defw RaderVram+VramRowSize*10
    defw RaderVram+VramRowSize*11
RowAddressHl:
    rra | rra
    and 1eh
    add a,low YTable | ld l,a
    ld a,high YTable | adc a,0 | ld h,a
    ld a,(hl) | inc hl
    ld h,(hl)
    ld l,a
ret

; void PrintRader();
cseg
PrintRader_: public PrintRader_
    push af | push hl | push de| push bc
        ld hl,RaderVram
        ld de,VramRowSize - RaderWidth * VramStep
        ld c,RaderHeight
        do
            ld b,RaderWidth
            do
                ld (hl),Char_Logo+0fh
                inc hl
            dwnz
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawFortRader(byte x, byte y, bool visible);
cseg
DrawFortRader_: public DrawFortRader_
    push af | push hl | push de
        rra | rra
        and 0eh
        ld d,a
            ld a,e
            call RowAddressHl
        ld e,d
        srl e
        ld d,0
        add hl,de

        ld a,c | or a
        if nz
            ld (hl),Char_Logo+00h
        else
            ld (hl),Char_Logo+0fh
        endif
    pop de | pop hl | pop af
ret


; void DrawFighterOnRader()
cseg
DrawFighterOnRader_: public DrawFighterOnRader_
    push af | push hl | push de
        ld a,(FighterY_)
        dec a
        ld e,a
        and 0feh
        call RowAddressHl

        ld a,(FighterX_)
        dec a
        ld d,a
        rra | rra | rra
        and 07h
        add a,l | ld l,a
        ld a,h | adc a,0 | ld h,a

        ld a,e | and 4
        if z
            ld a,d | and 4
            if z
                ld e,01h
            else
                ld e,04h
            endif
        else
            ld a,d | and 4
            if z
                ld e,02h
            else
                ld e,08h
            endif
        endif
        ld a,(hl)
        xor e
        ld (hl),a
    pop de | pop hl | pop af
ret
