include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push v | push b
        mov c,a

        mov a,e
        add a,a ;*2
        add a,e ;*3
        add a,a ;*6

        add a,a | mov l,a ;*12
        mvi a,0 | aci a,0 | mov h,a

        mov a,l | add a,a | mov l,a ;*24
        mov a,h | adc a,a | mov h,a

        mov a,l | add a,c | mov l,a
        mov a,h | aci a,0 | mov h,a

        mov a,l | adi a,low VVram_ | mov l,a
        mov a,h | aci a,high VVram_ | mov h,a
    pop b | pop v
ret
