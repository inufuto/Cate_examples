ext PrintC_, PrintC_@Param0

ch equ PrintC_@Param0

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
rts


; void PrintByteNumber3(byte b);
dseg
PrintByteNumber3_@Param0 : public PrintByteNumber3_@Param0
    defb 0
cseg
PrintByteNumber3_: public PrintByteNumber3_
    pha
        lda PrintByteNumber3_@Param0 | sta value
        
        ldx #0 | stx zeroVisible

        lda #100 | sta num | jsr PrintDigitB
        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | sta ch
        jsr PrintC_
    pla
rts


; void PrintByteNumber2(byte b);
dseg
PrintByteNumber2_@Param0 : public PrintByteNumber2_@Param0
    defb 0
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pha
        lda PrintByteNumber2_@Param0 | sta value
        
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
rts


; void PrintNumber5(word w);
dseg
PrintNumber5_@Param0 : public PrintNumber5_@Param0
    defw 0
cseg
PrintNumber5_: public PrintNumber5_
    pha
        lda PrintNumber5_@Param0 | sta value
        lda PrintNumber5_@Param0+1 | sta value+1

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
