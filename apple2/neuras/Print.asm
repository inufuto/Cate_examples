ext PrintC_, PrintC_@Param0, PrintC_@Param1

ch equ PrintC_@Param1
pVram equ PrintC_@Param0

dseg
zeroVisible:
    defb 0
value:
    defw 0
num:
    defw 0
count:
    defb 0

cseg
PrintDigitB:
    lda #'0' | sta ch

    lda value
    do
        sec|sbc num
    while cs
        ldx ch | inx | stx ch
    wend
    clc|adc num
    sta value
    
    lda ch
    cmp #'0'
    if eq
        ldx zeroVisible
        if eq
            lda #' '
        endif
        sta ch
    else
        ldx #1 | stx zeroVisible
    endif

    jsr PrintC_
    sty pVram | stx pVram+1
rts


; ; word PrintByteNumber3(word vram, byte b);
; dseg
; PrintByteNumber3_@Param0 : public PrintByteNumber3_@Param0
;     defw 0
; PrintByteNumber3_@Param1 : public PrintByteNumber3_@Param1
;     defb 0
; cseg
; PrintByteNumber3_: public PrintByteNumber3_
;     pha
;         ldx PrintByteNumber3_@Param0 | stx pVram
;         ldx PrintByteNumber3_@Param0+1 | stx pVram+1

;         lda PrintByteNumber3_@Param1 | sta value
        
;         ldx #0 | stx zeroVisible

;         lda #100 | sta num | jsr PrintDigitB
;         lda #10 | sta num | jsr PrintDigitB
;         lda value | clc|adc #'0' | sta ch
;         jsr PrintC_
;     pla
; rts


; word PrintByteNumber2(word vram, byte b);
dseg
PrintByteNumber2_@Param0 : public PrintByteNumber2_@Param0
    defw 0
PrintByteNumber2_@Param1 : public PrintByteNumber2_@Param1
    defb 0
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pha
        ldx PrintByteNumber2_@Param0 | stx pVram
        ldx PrintByteNumber2_@Param0+1 | stx pVram+1

        lda PrintByteNumber2_@Param1 | sta value
        
        ldx #0 | stx zeroVisible

        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | sta ch
        jsr PrintC_
    pla
rts


cseg
PrintDigitW:
    lda #'0' | sta ch
    do
        lda value | sec|sbc num | sta value
        lda value+1 | sbc num+1 | sta value+1
    while cs
        ldx ch | inx | stx ch
    wend
    lda value | clc|adc num | sta value
    lda value+1 | adc num+1 | sta value+1

    lda ch
    cmp #'0'
    if eq
        ldx zeroVisible
        if eq
            lda #' '
        endif
        sta ch
    else
        ldx #1 | stx zeroVisible
    endif

    jsr PrintC_
    sty pVram | stx pVram+1
rts


; word PrintNumber5(word vram, word w);
dseg
PrintNumber5_@Param0 : public PrintNumber5_@Param0
    defw 0
PrintNumber5_@Param1 : public PrintNumber5_@Param1
    defw 0
cseg
PrintNumber5_: public PrintNumber5_
    pha
        lda PrintNumber5_@Param0 | sta pVram
        lda PrintNumber5_@Param0+1 | sta pVram+1
        
        lda PrintNumber5_@Param1 | sta value
        lda PrintNumber5_@Param1+1 | sta value+1

        ldx #0 | stx zeroVisible

        lda #low 10000 | sta num
        lda #high 10000 | sta num+1
        jsr PrintDigitW

        lda #low 1000 | sta num
        lda #high 1000 | sta num+1
        jsr PrintDigitW

        lda #low 100 | sta num
        lda #high 100 | sta num+1
        jsr PrintDigitW

        lda #low 10 | sta num
        lda #high 10 | sta num+1
        jsr PrintDigitW

        lda value | clc|adc #'0' | sta ch
        jsr PrintC_
    pla
rts


; word PrintNumber3(word vram, word w);
dseg
PrintNumber3_@Param0 : public PrintNumber3_@Param0
    defw 0
PrintNumber3_@Param1 : public PrintNumber3_@Param1
    defw 0
cseg
PrintNumber3_: public PrintNumber3_
    pha
        lda PrintNumber3_@Param0 | sta pVram
        lda PrintNumber3_@Param0+1 | sta pVram+1
        
        lda PrintNumber3_@Param1 | sta value
        lda PrintNumber3_@Param1+1 | sta value+1

        ldx #0 | stx zeroVisible

        lda #low 100 | sta num
        lda #high 100 | sta num+1
        jsr PrintDigitW

        lda #low 10 | sta num
        lda #high 10 | sta num+1
        jsr PrintDigitW

        lda value | clc|adc #'0' | sta ch
        jsr PrintC_
    pla
rts
