dseg

; RndIndex_: public RndIndex_
;     defw 0
; cseg
; Numbers:
;     defb 26,30,1,16,9,13,12,5
;     defb 14,15,27,7,4,3,24,20
;     defb 8,18,22,10,19,21,23,6
;     defb 2,29,28,11,31,0,17,25
; RndCount equ 32

; ; byte Rnd();
; cseg
;     Rnd_: public Rnd_
;     dect r10 | mov r1,*r10
;         mov @RndIndex_,r1
;         clr r0
;         movb @Numbers(r1),r0
;         inc r1
;         andi r1,RndCount-1
;         mov r1,@RndIndex_
;     mov *r10+,r1
; rt


; byte Abs(byte a, byte b)
cseg
Abs_: public Abs_
    sb r1,r0
    if nc
        neg r0
    endif
rt


; sbyte Sign(byte from, byte to)
cseg
Sign_: public Sign_
    sb r1,r0
    if ne
        if oc
            li r0,>-1 shl 8
        else
            li r0,>1 shl 8
        endif
    endif
rt
