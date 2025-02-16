include "VVram.inc"
include "Chars.inc"

ext Background_, DotOffset_

TileWidth equ 2
BackgroundWidth equ VVramWidth+TileWidth


dseg
VVram_: public VVram_
    defs VVramWidth*VVramHeight


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            add hl,hl ;*8
            add hl,hl ;*16
            add hl,hl ;*32
        ex de,hl
        ld l,a
        ld h,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret


; extern void BackgroundToVVram();
cseg
BackgroundToVVram_: public BackgroundToVVram_
    push af | push hl | push de | push bc
        ld a,(DotOffset_)
        and 3
        exx | ld e,a | exx
        
        ld de,Background_
        ld hl,VVram_
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(de) | inc de
                cp Char_Ground+1
                if nc
                    exx | add a,e | exx
                endif
                ld (hl),a | inc hl
            dwnz
            inc de | inc de ; add de,BackgroundWidth-VVramWidth
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
