include "VVram.inc"
include "Chars.inc"

ext CellMap_
ext VVram_

MapWidth equ 12
MapHeight equ 7
MapWidthPerByte equ 8/4

Cell_Wall equ 1h
Cell_Rock equ 2h
Cell_Arrow equ 4h
Cell_NullArrow equ 0ch

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push de
        ld d,0
        ld l,e
        ld h,d
        add hl,hl ;*2
        add hl,de ;*3
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld e,a
        ld d,0
        add hl,de
        ld de,VVram_
        add hl,de
    pop de
ret


; void MapToVVram();
MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc
        ld de,CellMap_
        ld hl,VVram_
        ld c,MapHeight
        do
            ld b,MapWidth/MapWidthPerByte
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,a
                        ld b,MapWidthPerByte
                        do
                            push bc
                                ld de,VVramWidth-2
                                ld a,c
                                and 0fh
                                cp Cell_Wall
                                if z
                                    ld a,Char_Wall
                                    jr vput2
                                endif
                                cp Cell_Rock
                                if z
                                    ld a,Char_Rock
                                    jr vput2
                                endif
                                and 0ch
                                cp Cell_Arrow
                                if z
                                    ld a,c
                                    rlca | rlca
                                    and 0ch
                                    add a,Char_Arrow
                                                        _deb:public _deb
                                    vput2:
                                    ld c,2
                                    do
                                        ld b,2
                                        do
                                            ld (hl),a | inc hl
                                            inc a
                                        dwnz
                                        add hl,de
                                        dec c
                                    while nz | wend
                                    jr next
                                endif                                    
                                xor a
                                ld c,2
                                do
                                    ld b,2
                                    do
                                        ld (hl),a | inc hl
                                    dwnz
                                    add hl,de
                                    dec c
                                while nz | wend
                                next:
                                ld de,2-VVramWidth*2
                                add hl,de
                            pop bc
                            ld a,c
                            rrca | rrca | rrca | rrca
                            ld c,a
                        dwnz
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret