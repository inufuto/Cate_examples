include "VVram.inc"
include "Chars.inc"

MapWidth equ 16
MapHeight equ 11

ext CellMap_, VVram_

cseg

; word ptr<byte> VVramPtr(byte x, byte y);
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


; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public CellMapPtr_
    push af | push de
        ex de,hl
            ld h,0
            add hl,hl ;*2
            add hl,hl ;*4
            ld de,CellMap_
            add hl,de
        ex de,hl
        srl a
        srl a
        ld l,a
        ld h,0
        add hl,de
    pop de | pop af
ret


; void CellMapToVVram();
cseg
CellMapToVVram_: public CellMapToVVram_
    push af | push hl | push de | push bc
        ld ix,VVram_
        ld hl,CellMap_
        ld b,MapHeight ; vertical count    
        do
            push bc
                ld c,MapWidth/4
                do 
                    ld e,(hl) | inc hl
                    ld b,4
                    do
                        ld a,e
                        and 3
                        if z
                            ld (ix),Char_Space
                            ld (ix+1),Char_Space
                            ld (ix+VVramWidth),Char_Space
                            ld (ix+VVramWidth+1),Char_Space
                        else
                            dec a
                            if z
                                ld d,Char_Block
                            else
                                ld d,Char_Wall
                            endif
                            ld (ix),d | inc d
                            ld (ix+1),d | inc d
                            ld (ix+VVramWidth),d | inc d
                            ld (ix+VVramWidth+1),d
                        endif
                        srl e | srl e
                        inc ix | inc ix
                    dwnz
                    dec c
                while nz | wend
                ld de,VVramWidth
                add ix,de
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret
