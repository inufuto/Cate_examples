include "ZeroPage.inc"
include "VVram.inc"

ext VVram_

pVVram equ ZW0


; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_x:	
    defb 0
VVramPtr_@Param1: public	VVramPtr_@Param1
VVramPtr_y:	
    defb 0
cseg
VVramPtr_: public	VVramPtr_
    pha
        sty VVramPtr_x
        
        lda #0 | sta <pVVram+1
        lda VVramPtr_y
        asl a | clc|adc VVramPtr_y ;*3
        asl a | ;*6
        asl a | rol <pVVram+1 ;12
        asl a | rol <pVVram+1 ;24
        sta <pVVram

        lda VVramPtr_x
        asl a | clc|adc VVramPtr_x ;*3
        lsr a | lsr a ;/4
        clc|adc <pVVram | sta <pVVram
        lda <pVVram+1 | adc #0 | sta <pVVram+1
        
        lda <pVVram | clc|adc #low VVram_ | tay
        lda <pVVram+1 | adc #high VVram_ | tax
    pla
rts
