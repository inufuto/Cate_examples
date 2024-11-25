include "VVram.inc"

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
WallChars:
    defb 0e0h, 0d0h, 0b0h, 70h
RockChars:
    defb 10h, 0a0h, 0f0h, 0f0h
ArrowChars:
	defb 60h, 80h, 40h, 80h, 0c0h, 20h, 0c0h, 00h
	defb 60h, 20h, 80h, 80h, 0a0h, 0a0h, 40h, 00h
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
                                ld a,c
                                and 0fh
                                cp Cell_Wall
                                if z
                                    ld de,WallChars
                                    jr vput2
                                endif
                                cp Cell_Rock
                                if z
                                    ld de,RockChars
                                    jr vput2
                                endif
                                and 0ch
                                cp Cell_Arrow
                                if z
                                    ld a,c
                                    rlca | rlca
                                    and 0ch
                                    add a,low ArrowChars | ld e,a
                                    ld a,high ArrowChars | adc a,0 | ld d,a
                                    vput2:
                                    ld c,2
                                    do
                                        ld b,2
                                        do
                                            ld a,(de) | inc de
                                            ld (hl),a | inc hl
                                            inc a
                                        dwnz
                                        push de
                                            ld de,VVramWidth-2
                                            add hl,de
                                        pop de
                                        dec c
                                    while nz | wend
                                    jr next
                                endif                                    
                                xor a
                                ld de,VVramWidth-2
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

        ld bc,80h or (VVramWidth shl 8)
        do
            ld (hl),c | inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> VPrintC(ptr<byte> pVVram, byte c);
cseg
VPrintC_: public VPrintC_
    push af | push hl | push de | push bc
                                            _deb: public _deb
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
