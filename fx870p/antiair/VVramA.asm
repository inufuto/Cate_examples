include "VVram.inc"

ext VVram_
ext Ground_
ext BlockChars_


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public	VVramPtr_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        ld $11,$sx
        biuw $10 ;*6
        biuw $10 ;*12
        biuw $10 ;*24
        ld $12,$0
        ld $13,$sx
        adw $10,$12
        ldw $12,VVram_
        adw $10,$12
    ppsw $12
rtn


Ground_BlockMask equ &h03
Ground_BombMask equ &h0c

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    phsm $3,4
    phsm $11,2
        pre iz,VVram_
        ldw $10,VVramWidth*(VVramHeight-2)
        do
            sti $31,(iz+$sx)
            sbw $10,$sy
        while nz | wend

        ld $1,$sx
        pre ix,Ground_
        ld $3,VVramWidth
        do
            ldi $0,(ix+$sx)
            ld $2,$0
            an $0,Ground_BombMask
            if nz
                bid $0 | bid $0
                ad $0,8-1,DrawBackground_write
            endif
            ld $0,$2
            an $0,Ground_BlockMask
            if nz
                sb $0,$sy
                DrawBackground_write:
                ldw $10,BlockChars_
                adw $10,$0
                ld $0,($10)
                st $0,(iz+$sx)
                adw $10,$sy | adw $10,$sy
                ld $0,($10)
            else
                st $0,(iz+$sx)
            endif
            st $0,(iz+VVramWidth)
            ldi $0,(iz+$sx)
            sb $3,$sy
        while nz | wend
    ppsm $10,2
    ppsm $0,4
rtn
