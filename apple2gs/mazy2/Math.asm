include "ZeroPage.inc"

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
; Rnd_return equ @zp+0
; Rnd_: public Rnd_
;     php
;         phx
;         rep #$20 | a16
;         pha
;             lda RndIndex_ | and #RndCount-1 | tax
;             sep #$20 | a8
;             lda Numbers,x
;             sta <Rnd_return
;             txa
;             inc a
;             and #RndCount-1
;             sta RndIndex_
;         rep #$20 | a16
;         pla
;         plx
;     plp
; rts


; byte Abs(byte a, byte b);
Abs_a equ @ZP+0
Abs_b equ @ZP+2
Abs_return equ @ZP+0
cseg
Abs_: public Abs_
    php
        sep #$20 | a8
        pha
            lda <Abs_a
            sec|sbc <Abs_b
            if cc
                eor #$ff
                inc a
            endif
            sta <Abs_return
        pla
    plp
rts


; sbyte Sign(byte from, byte to);
Sign_from equ @ZP+0
Sign_to equ @ZP+2
Sign_return equ @ZP+0
cseg
Sign_: public Sign_
    php
        sep #$20 | a8
        pha
            lda <Sign_from
            sec|sbc <Sign_to
            if ne
                if cs
                    lda #-1
                else
                    lda #1
                endif
            endif
            sta <Sign_return
        pla
    plp
rts
