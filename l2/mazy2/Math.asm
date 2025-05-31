ext @Temp@Byte
ext @Temp@Word

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
;     pshb
;         ldaa RndIndex_
;         adda #low Numbers
;         staa <@Temp@Word+1
;         ldaa #high Numbers
;         adca #0
;         staa <@Temp@Word
;         ldx <@Temp@Word
;         ldaa 0,x
        
;         ldab RndIndex_
;         incb
;         andb #RndCount-1
;         stab RndIndex_
;     pulb
; rts


; byte Abs(byte a, byte b);
dseg
Abs_@Param1: public Abs_@Param1
    defb 0
cseg
Abs_: public Abs_
    suba Abs_@Param1
    if cs
        nega
    endif
rts


; sbyte Sign(byte from, byte to);
dseg
Sign_@Param1: public Sign_@Param1
    defb 0
cseg
Sign_: public Sign_
    suba Sign_@Param1
    if ne
        if cs
            ldaa #1
        else
            ldaa #-1
        endif
    endif
rts
