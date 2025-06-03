include "VVram.inc"

ext VVramBack_, VVramFront_

; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push psw | push b | push d
        mov c,a | mvi b,0
        mov a,e
        add a ;*2
        add a ;*4
        add e ;*5
        mov l,a | mvi h,0
        mov e,l | mov d,h
        dad h ;*10
        dad h ;*20
        dad d ;*25
        dad b
    pop d | pop b | pop psw
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