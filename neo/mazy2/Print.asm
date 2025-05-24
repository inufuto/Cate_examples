ext PrintC_, PrintC_@Param1

PrintC_c equ PrintC_@Param1


dseg
PrintByteNumber3_@Param1 : public PrintByteNumber3_@Param1
PrintByteNumber2_@Param1 : public PrintByteNumber2_@Param1
PrintNumber5_@Param1 : public PrintNumber5_@Param1
PrintNumber3_@Param1 : public PrintNumber3_@Param1
PrintNumber_v:
    defw 0
value:
    defw 0
num:
    defw 0
count:
    defb 0
zseg
zeroVisible:
    defb 0

cseg
PrintDigitB:
    lda #'0' | sta PrintC_c

    lda value
    do
        sec|sbc num
    while cs
        inc PrintC_c
    wend
    clc|adc num
    sta value
    
    lda PrintC_c
    cmp #'0'
    if eq
        if br0 zeroVisible
            lda #' '
        endif
        sta PrintC_c
    else
        smb0 zeroVisible
    endif

    jsr PrintC_
rts


; byte PrintByteNumber3(byte x, byte y, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    pha
        lda PrintNumber_v | sta value
        
        stz zeroVisible

        lda #100 | sta num | jsr PrintDigitB
        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | sta PrintC_c
        jsr PrintC_
    pla
rts


; word PrintByteNumber2(word yx, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pha
        lda PrintNumber_v | sta value
        
        stz zeroVisible

        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | sta PrintC_c
        jsr PrintC_
    pla
rts


cseg
PrintDigitW:
    lda #'0' | sta PrintC_c
    do
        lda value | sec|sbc num | sta value
        lda value+1 | sbc num+1 | sta value+1
    while cs
        inc PrintC_c
    wend
    lda value | clc|adc num | sta value
    lda value+1 | adc num+1 | sta value+1

    lda PrintC_c
    cmp #'0'
    if eq
        if br0 zeroVisible
            lda #' '
        endif
        sta PrintC_c
    else
        smb0 zeroVisible
    endif

    jsr PrintC_
rts


; word PrintNumber5(word yx, word w);
cseg
PrintNumber5_: public PrintNumber5_
    pha
        lda PrintNumber_v | sta value
        lda PrintNumber_v+1 | sta value+1

        stz zeroVisible

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

        lda value | clc|adc #'0' | sta PrintC_c
        jsr PrintC_
    pla
rts

