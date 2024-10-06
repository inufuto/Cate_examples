ext PrintC_, PrintC_@Param1

ch equ PrintC_@Param1

dseg
pVram:
    defw 0
zeroVisible:
    defb 0
value:
    defw 0
num:
    defw 0
count:
    defb 0
Param_value:
PrintByteNumber3_@Param1 : public PrintByteNumber3_@Param1
PrintByteNumber2_@Param1 : public PrintByteNumber2_@Param1
PrintNumber5_@Param1 : public PrintNumber5_@Param1
; PrintNumber3_@Param1 : public PrintNumber3_@Param1
    defw 0


cseg
PrintC:
    ldy pVram | ldx pVram+1
    jsr PrintC_
    sty pVram | stx pVram+1
rts

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
        beq PrintDigitB_skip
    else
        inc zeroVisible
    endif
    jsr PrintC
    PrintDigitB_skip:
rts


; ptr<byte> PrintByteNumber3(ptr<byte> pVram, byte b, bool right);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    pha
        sty pVram | stx pVram+1

        lda Param_value | sta value
        
        ldx #0 | stx zeroVisible

        lda #100 | sta num | jsr PrintDigitB
        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | sta ch
        jsr PrintC
    pla
rts


; word PrintByteNumber2(word vram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pha
        sty pVram | stx pVram+1

        lda Param_value | sta value
        
        ldx #0 | stx zeroVisible

        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | sta ch
        jsr PrintC
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
        beq PrintDigitW_skip
    else
        inc zeroVisible
    endif
    jsr PrintC
    PrintDigitW_skip:
rts


; word PrintNumber5(word vram, word w);
cseg
PrintNumber5_: public PrintNumber5_
    pha
        sty pVram | stx pVram+1
        
        lda Param_value | sta value
        lda Param_value+1 | sta value+1

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
        jsr PrintC
    pla
rts
