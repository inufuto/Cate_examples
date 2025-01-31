include "VVram.inc"
include "Vram.inc"

ext VVram_


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public	VVramPtr_
    phsw $13
        ld $10,$1 ; y
        biu $10 ;*2
        biu $10 ;*4
        biu $10 ;*8
        ad $10,$0 ;x
        ld $11,$sx
        ldw $12,VVram_
        adw $10,$12
    ppsw $12
rtn
