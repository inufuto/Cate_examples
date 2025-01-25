; RndCount equ 32

; dseg
; RndIndex_: public RndIndex_
;     defb 0
    
; cseg
; Numbers:
;     defb 26,30,1,16,9,13,12,5
;     defb 14,15,27,7,4,3,24,20
;     defb 8,18,22,10,19,21,23,6
;     defb 2,29,28,11,31,0,17,25

; ; byte Rnd();
; cseg
; Rnd_: public Rnd_
;     pushw rr2
;         mov r3,@RndIndex_
;         clr r2
;         addw rr2,Numbers
;         mov r1,@rr2
;         mov r3,@RndIndex_
;         inc r3
;         and r3,RndCount-1
;         mov @RndIndex_,r3
;     popw rr2
; ret


; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
    sub r1,r3
    if c
        neg r1
    endif
ret


; ; sbyte Sign(byte from, byte to);
; cseg
; Sign_: public Sign_
;     sub r1,r3
;     if nz
;         if c
;             mov r0,-1
;         else
;             mov r0,1
;         endif
;     endif
; ret
