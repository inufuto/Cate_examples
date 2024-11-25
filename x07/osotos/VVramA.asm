include "VVram.inc"

ext VVram_
ext CellMap_


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


ColumnCount equ 12
FloorCount equ 4
FloorHeight equ 4

Cell_Down equ 1
Cell_Up equ 2
Cell_Block equ 8
Cell_Ceiling equ 4
Cell_Item equ 4

Char_Floor equ 0c0h
Char_LadderL equ 0e0h
Char_LadderR equ 0d0h
Char_Space equ 00h


; void DrawBackground();
cseg
FloorChars:
    defb Char_Floor, Char_Floor, Char_Space, Char_Space
LadderChars:
    defb Char_LadderL, Char_LadderR, Char_LadderL, Char_LadderR
BlockChars:
    defb 0e0h, 0d0h, 0b0h, 70h
ItemChars:
    defb 60h, 90h, 90h, 60h
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc
        ld de,CellMap_
        ld hl,VVram_-VVramWidth*1
        exx
            ld e,-2 ; y
        exx
        ld c,FloorCount
        do
            ld b,ColumnCount
            do
                push bc
                    ld a,(de) | inc de
                    push de
                        ld c,a
                        exx
                            ld a,e
                        exx
                        cp VVramHeight
                        if c
                            ld a,c | and Cell_Block
                            if nz
                                ld de,BlockChars
                                call VPut2S
                                jr lower
                            endif
                            ld a,c | and Cell_Ceiling
                            if nz
                                ld de,FloorChars
                                call VPut2S
                                jr lower
                            endif
                            ld a,c | and Cell_Down or Cell_Up
                            if nz
                                ld de,LadderChars
                                call VPut2S
                                jr lower
                            endif
                            call VErase2
                        else
                            ld de,VVramWidth*2
                            add hl,de
                        endif
                        lower:
                        srl c | srl c | srl c | srl c

                        ld a,c | and Cell_Block
                        if nz
                            ld de,BlockChars
                            call VPut2S
                            jr next
                        endif
                        ld a,c | and Cell_Item
                        if nz
                            ld de,ItemChars
                            call VPut2S
                            jr next
                        endif
                        ld a,c | and Cell_Down or Cell_Up
                        if nz
                            ld de,LadderChars
                            call VPut2S
                            jr next
                        endif
                        call VErase2
                        next:

                        ld de,2-VVramWidth*4
                        add hl,de
                    pop de
                pop bc
            dwnz
            push de
                ld de,VVramWidth*(4-1)
                add hl,de
            pop de
            exx
                inc e | inc e | inc e | inc e
            exx
            dec c
        while nz | wend
        ld bc,Char_Floor or (VVramWidth shl 8)
        do
            ld (hl),c | inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret
VPut2S:
    push bc
        ld c,2
        do
            ld b,2
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push de
                ld de,VVramWidth-2
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc
ret
VErase2:
    push de | push bc
        xor a
        ld c,2
        do
            ld b,2
            do
                ld (hl),a | inc hl
            dwnz
            ld de,VVramWidth-2
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de
ret


; ptr<byte> VPrintC(ptr<byte> pVVram, byte c);
cseg
VPrintC_: public VPrintC_
    push af | push hl | push de | push bc
        ld a,e
        ex de,hl
            ld bc,AsciiCount shl 8
            ld hl,AsciiTable
            do
                cp (hl)
                jr z,VPrintC_break
                inc hl
                inc c | inc c | inc c | inc c | inc c | inc c
            dwnz
            ld c,0
            VPrintC_break:
            ld b,0
            ld hl,AsciiPattern
            add hl,bc
        ex de,hl
        ld c,3
        do
            ld b,2
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push bc
                ld bc,VVramWidth-2
                add hl,bc
            pop bc
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
    inc hl | inc hl
ret 
AsciiCount equ 26
AsciiTable:
	defb " 0123456789ACEGHIMNOPRSTUV"
AsciiPattern:
	defb 00h,00h,00h,00h,00h,00h,0e0h,0a0h
	defb 0a0h,0a0h,0c0h,80h,00h,0a0h,00h,0a0h
	defb 00h,80h,0c0h,0a0h,0e0h,80h,0c0h,80h
	defb 0c0h,0a0h,0c0h,0a0h,0c0h,80h,0a0h,0a0h
	defb 0c0h,0a0h,00h,80h,0e0h,80h,0c0h,0a0h
	defb 0c0h,80h,0e0h,80h,0e0h,0a0h,0c0h,80h
	defb 0c0h,0a0h,50h,00h,40h,00h,0e0h,0a0h
	defb 0e0h,0a0h,0c0h,80h,0e0h,0a0h,0c0h,0a0h
	defb 0c0h,80h,60h,20h,0b0h,0a0h,80h,80h
	defb 60h,20h,0a0h,20h,40h,00h,0e0h,80h
	defb 0e0h,00h,0c0h,80h,60h,80h,0a0h,0a0h
	defb 40h,00h,0a0h,0a0h,0e0h,0a0h,80h,80h
	defb 0d0h,80h,50h,00h,0c0h,80h,0b0h,0a0h
	defb 0e0h,0a0h,80h,80h,0e0h,20h,0a0h,0a0h
	defb 80h,80h,60h,20h,0a0h,0a0h,40h,00h
	defb 0e0h,0a0h,0e0h,80h,80h,00h,0e0h,20h
	defb 0e0h,20h,80h,80h,60h,80h,0c0h,0a0h
	defb 0c0h,00h,0d0h,80h,50h,00h,40h,00h
	defb 0a0h,0a0h,0a0h,0a0h,0c0h,80h,0a0h,0a0h
	defb 0a0h,0a0h,40h,00h
