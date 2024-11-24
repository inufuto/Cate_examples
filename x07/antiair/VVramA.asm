include "VVram.inc"

ext VVram_
ext Ground_
ext BlockChars_

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


Ground_BlockMask equ 03h
Ground_BombMask equ 0ch
Char_Space equ 00h

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc
        ld hl,VVram_
        ld (hl),Char_Space
        ld de,VVram_+1
        ld bc,VVramWidth*(VVramHeight-2)-1
        ldir

        ld de,VVram_+VVramWidth*(VVramHeight-2)
        exx
            ld de,VVram_+VVramWidth*(VVramHeight-2)+VVramWidth
        exx
        ld hl,Ground_
        ld b,VVramWidth
        do
            ld c,(hl) | inc hl
            push hl
                ld a,c | and Ground_BombMask
                if nz
                    rrca | rrca
                    add a,8-1
                    jr DrawBackground_write
                endif
                ld a,c | and Ground_BlockMask
                if nz
                    dec a
                    DrawBackground_write:
                                            _deb: public _deb
                    add a,low BlockChars_ | ld l,a
                    ld a,high BlockChars_ | adc a,0 | ld h,a
                    ld a,(hl)
                    ld (de),a
                    inc hl | inc hl
                    ld a,(hl)
                    exx
                        ld (de),a
                    exx
                else
                    ld a,Char_Space
                    ld (de),a
                    exx
                        ld (de),a
                    exx
                endif
                inc de
                exx
                    inc de
                exx
            pop hl
        dwnz
    pop bc | pop de | pop hl | pop af
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
AsciiCount equ 27
AsciiTable:
	defb " 0123456789ACEGHIKMNOPRSUVY"
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
	defb 0d0h,80h,50h,00h,0c0h,80h,0a0h,0a0h
	defb 0e0h,20h,80h,80h,0b0h,0a0h,0e0h,0a0h
	defb 80h,80h,0e0h,20h,0a0h,0a0h,80h,80h
	defb 60h,20h,0a0h,0a0h,40h,00h,0e0h,0a0h
	defb 0e0h,80h,80h,00h,0e0h,20h,0e0h,20h
	defb 80h,80h,60h,80h,0c0h,0a0h,0c0h,00h
	defb 0a0h,0a0h,0a0h,0a0h,0c0h,80h,0a0h,0a0h
	defb 0a0h,0a0h,40h,00h,0a0h,0a0h,50h,00h
	defb 40h,00h
