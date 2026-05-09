include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push psw | push b
        mov c,a | mvi b,0
        mov a,e
        mov l,a | mvi h,0
        dad h ;*2
        dad h ;*4
        dad h ;*8
        dad h ;*16
        dad h ;*32
        dad b
        lxi b,VVram_
        dad b
    pop b | pop psw
ret
