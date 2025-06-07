include "VVram.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push v | push b
        mov c,a

        mov a,e
        add a,a ;*2
        add a,a ;*4
        add a,e ;*5
        mov e,a
        
        add a,a | mov l,a ;*10
        mvi a,0 | aci a,0 | mov h,a

        mov a,l | add a,a | mov l,a ;*20
        mov a,h | adc a,a | mov h,a

        mov a,l | add a,e | mov l,a
        mov a,h | aci a,0 | mov h,a

        mov a,l | add a,c | mov l,a
        mov a,h | aci a,0 | mov h,a

        mov a,l | adi a,low VVram_ | mov l,a
        mov a,h | aci a,high VVram_ | mov h,a
    pop b | pop v
ret


; ptr<byte> VPut(ptr<byte> pVVram, byte c);
cseg
VPut_: public VPut_
    push v
        mov a,e
        stax h+
    pop v
ret
