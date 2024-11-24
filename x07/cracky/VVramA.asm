include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
VVramPtr_: public VVramPtr_
    push af | push bc
        ld c,a
        ld a,e
        add a,a ;*2
        add a,e ;*3
        ld l,a
        ld h,0
        add hl,hl ;*6
        add hl,hl ;*12
        add hl,hl ;*24
        ld b,0
        add hl,bc
        ld bc,VVram_
        add hl,bc
    pop bc | pop af
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
AsciiCount equ 28
AsciiTable:
	defb " 0123456789ACEGHIKMNOPRSTUVY"
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
	defb 0d0h,80h,50h,00h,40h,00h,0a0h,0a0h
	defb 0a0h,0a0h,0c0h,80h,0a0h,0a0h,0a0h,0a0h
	defb 40h,00h,0a0h,0a0h,50h,00h,40h,00h
