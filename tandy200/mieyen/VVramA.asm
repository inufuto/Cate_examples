include "VVram.inc"

ext VVramBack_, VVramFront_

; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
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
    pop b | pop psw
ret


; void VVramBackToFront();
VVramBackToFront_: public VVramBackToFront_
    push psw | push h | push d | push b
        lxi h,VVramFront_
        lxi d,VVramBack_
        lxi b,VVramWidth*VVramHeight
        do
            ldax d | inx d
            mov m,a | inx h
            dcx b
            mov a,c
            ora b
        while nz | wend
    pop b | pop d | pop h | pop psw
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    mov m,e
    inx h
ret