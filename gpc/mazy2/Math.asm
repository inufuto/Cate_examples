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
;     push h
;         mov a,RndIndex_
;         adi a,low Numbers
;         mov l,a
;         mvi a,high Numbers
;         aci a,0
;         mov h,a
;         ldax h
;         mov l,a
        
;         mov a,RndIndex_
;         inr a
;         ani a,RndCount-1
;         mov RndIndex_,a
        
;         mov a,l
;     pop h
; ret


; byte Abs(byte a, byte b);
Abs_: public Abs_
    sub	a,e
    sknz | ret
    if sknc
    else
        xri a,$ff | inr a
    endif
ret


; sbyte Sign(byte from, byte to);
cseg
Sign_: public Sign_
    sub	a,e
    sknz | ret
    if sknc
        mvi a,-1
    else
        mvi a,1
    endif
ret
