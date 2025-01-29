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
;     pushs x
;         mv a,[RndIndex_]
;         mv x,Numbers
;         add x,a
;         mv a,[x]
;         pushs a
;             mv a,[RndIndex_]
;             inc a
;             and a,RndCount-1
;             mv a,[RndIndex_]
;         pops a
;     pops x
; ret


; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
    sub	a,il
    if nz
        if c
            xor a,0ffh
            inc a
        endif
    endif
ret
