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
;     phs $1
;         pre ix,RndIndex_
;         ld $1,(ix+$sx)
;         pre iz,Numbers
;         ld $0,(iz+$1)
;         ad $1,$sy
;         an $1,RndCount-1
;         st $1,(ix+$sx)
;     pps $1
; rtn


; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
    sb $0,$1
    if nz
        if c
            cmp $0
        endif
    endif
rtn


; ; sbyte Sign(byte from, byte to);
; cseg
; Sign_: public Sign_
;     sb $0,$1
;     if nz
;         if nc
;             ld $0,$sy
;         else
;             ld $0,-1
;         endif
;     endif
; rtn