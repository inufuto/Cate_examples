include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext Map_
ext BaseX_, BaseY_

pVVram equ ZW0

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


MapStep equ 8

pSource equ ZW0
pDestination equ ZW1


; void MapToVVram();
zseg
mapOffset:
    defb 0
vvramOffset:
    defb 0
mapByte:
    defb 0
cseg
MapToVVram_: public MapToVVram_
    pha
        lda BaseY_ | sta <pSource+0
        lda #0 | sta <pSource+1
        asl <pSource+0 | rol <pSource+1   ; *2
        asl <pSource+0 | rol <pSource+1   ; *4
        asl <pSource+0 | rol <pSource+1   ; *8 : MapStep
        
        lda <pSource+0 | clc|adc #low Map_ | sta <pSource+0
        lda <pSource+1 | adc #high Map_ | sta <pSource+1

        lda BaseX_
        lsr a | lsr a | lsr a
        clc|adc <pSource+0 | sta <pSource+0
        lda <pSource+1 | adc #0 | sta <pSource+1
        
        lda #1 | sta <mapByte
        lda BaseX_
        and #7
        tax
        do | while ne
            asl <mapByte
            dex
        wend
        ldy #0 | sty <mapOffset

        lda #low VVram_ | sta <pDestination+0
        lda #high VVram_ | sta <pDestination+1

        ldx #VVramHeight
        do
            ldy #0
            do
                sty <vvramOffset

                ldy <mapOffset
                lda (<pSource),y
                and <mapByte
                if ne
                    lda #Char_Wall
                else
                    lda #Char_Space
                endif
                
                asl <mapByte
                if eq
                    iny
                    inc <mapByte
                endif
                sty <mapOffset

                ldy <vvramOffset
                sta (<pDestination),y
                iny
                cpy #VVramWidth
            while ne | wend
            lda <mapOffset
            clc|adc #MapStep-VVramWidth/8
            sta <mapOffset
            
            lda <pDestination+0 | clc|adc #VVramWidth | sta <pDestination+0
            lda <pDestination+1 | adc #0 | sta <pDestination+1

            dex
        while ne | wend
    pla
rts
