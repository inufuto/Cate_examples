zseg
temp:
    defb 0

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
;     pshs x,b
;         ldb RndIndex_
;         ldx #Numbers
;         lda b,x
;         incb
;         andb #RndCount-1
;         stb RndIndex_
;     puls b,x
; rts


; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
    stb <temp
    suba <temp
    if mi
        nega
    endif
rts


; ; sbyte Sign(byte from, byte to);
; cseg
; Sign_: public Sign_
;     stb <temp
;     suba <temp
;     if ne
;         if lt
;             lda #1
;         else
;             lda #-1
;         endif
;     endif
; rts
