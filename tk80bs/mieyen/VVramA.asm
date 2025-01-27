include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push psw | push b
        mov c,a
        mov a,e
        add a ;*2
        add e ;*3
        mov l,a
        mvi h,0
        dad h ;*6
        dad h ;*12
        dad h ;*24
        mvi b,0
        dad b
        lxi b,VVram_
        dad b
    pop b | pop psw
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    mov m,e
    inx h
ret
