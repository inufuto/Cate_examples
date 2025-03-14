include "ZeroPage.inc"
include "VVram.inc"

ext VVram_

pVVram equ ZW0

; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        ldx #VVramHeight
        do
            ldy #0 | tya
            do
                sta (<pVVram),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            dex
        while ne | wend
    pla
rts


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defb 0
cseg
VVramPtr_: public VVramPtr_
	pha
        lda	VVramPtr_y
        asl a
        tax
        lda YTable,x | inx
        sta <pVVram
        lda YTable,x
        sta <pVVram+1
        
        tya | clc|adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
	pla
rts

Ytable:
defw Vvram_+VVramWidth*0
defw Vvram_+VVramWidth*1
defw Vvram_+VVramWidth*2
defw Vvram_+VVramWidth*3
defw Vvram_+VVramWidth*4
defw Vvram_+VVramWidth*5
defw Vvram_+VVramWidth*6
defw Vvram_+VVramWidth*7
defw Vvram_+VVramWidth*8
defw Vvram_+VVramWidth*9
defw Vvram_+VVramWidth*10
defw Vvram_+VVramWidth*11
defw Vvram_+VVramWidth*12
defw Vvram_+VVramWidth*13
defw Vvram_+VVramWidth*14
defw Vvram_+VVramWidth*15
defw Vvram_+VVramWidth*16
defw Vvram_+VVramWidth*17
defw Vvram_+VVramWidth*18
defw Vvram_+VVramWidth*19
defw Vvram_+VVramWidth*20
defw Vvram_+VVramWidth*21
defw Vvram_+VVramWidth*22
defw Vvram_+VVramWidth*23
defw Vvram_+VVramWidth*24
defw Vvram_+VVramWidth*25
defw Vvram_+VVramWidth*26
