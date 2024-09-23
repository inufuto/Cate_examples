include "VVram.inc"
include "Vram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_,LeftX_

ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte


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


CellChars:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor,Char_Floor
	; 2
	defb Char_Space,Char_Space
	defb Char_Item+0,Char_Item+1
	defb Char_Item+2,Char_Item+3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor


; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
    push af | push hl | push de | push bc
        ld a,(LeftX_)
        exx
            ld e,a
        exx
        srl a
        ld c,a
            srl a
            srl a
            ld e,a | ld d,0
            ld hl,CellMap_
            add hl,de
        ld a,c
        and 3
        ld c,a
        exx
            ld hl,VVram_
            ld b,VVramWidth*StageTop
            do
                ld (hl),Char_Space | inc hl
            dwnz

            ld a,e
            ld d,0
            and 1
            if nz
                dec hl
                dec d
            endif
        exx
        ld b,FloorCount
        do
            ld e,(hl) | inc hl
            push bc
                ld a,c
                ld c,4 ; shift count
                or a
                do | while nz
                    srl e | srl e
                    dec c
                    dec a
                wend
                exx
                    ld e,d ; xpos
                exx

                ld b,VVramWidth/2+1
                do
                    ld a,e
                    push hl | push bc
                        and 03h
                        ld l,a | ld h,0
                        add hl,hl ;*2
                        add hl,hl ;*4
                        add hl,hl ;*8
                        ld bc,CellChars
                        add hl,bc
                        ld c,FloorHeight
                        do
                            ld b,2
                            do
                                ld a,(hl) | inc hl
                                exx
                                    ld b,a
                                    ld a,e ; xpos
                                    cp VVramWidth
                                    if c
                                        ld (hl),b
                                    endif
                                    inc hl
                                    inc e
                                exx
                            dwnz
                            exx
                                dec e | dec e
                                push de
                                    ld de,VVramWidth-2
                                    add hl,de
                                pop de
                            exx
                            dec c
                        while nz | wend
                        exx
                            inc e | inc e
                            push de
                                ld de,-VVramWidth*FloorHeight+2
                                add hl,de
                            pop de
                        exx
                    pop bc | pop hl
                    srl e | srl e
                    dec c
                    if z
                        ld e,(hl) | inc hl
                        ld c,4 ; shift count
                    endif
                dwnz
                exx
                    push de
                        ld de,-VVramWidth-2+VVramWidth*FloorHeight
                        add hl,de
                    pop de
                exx
                ld a,c
                cp 4
                if z
                    dec hl
                endif
                ld de,MapWidth-(VVramWidth/2+1)/ColumnsPerByte-1
                add hl,de
            pop bc
        dwnz
    pop bc | pop de | pop hl | pop af
ret
