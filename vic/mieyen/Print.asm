ext PrintC_, Locate_

dseg
zeroVisible:
    defb 0
value:
    defw 0
num:
    defw 0
count:
    defb 0
ch:
    defb 0
; pVram:
;     defw 0

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

    ldy ch
    jsr PrintC_
rts


; word PrintByteNumber3(ptr<byte> pVram, byte b);
dseg
PrintByteNumber3_@Param1 : public PrintByteNumber3_@Param1
    defb 0
cseg
PrintByteNumber3_: public PrintByteNumber3_
    pha
        jsr Locate_

        lda PrintByteNumber3_@Param1 | sta value
        
        ldx #0 | stx zeroVisible

        lda #100 | sta num | jsr PrintDigitB
        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | tay
        jsr PrintC_
    pla
rts


; word PrintByteNumber2(ptr<byte> pVram, byte b);
dseg
PrintByteNumber2_@Param1 : public PrintByteNumber2_@Param1
    defb 0
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pha
        jsr Locate_

        lda PrintByteNumber2_@Param1 | sta value
        
        ldx #0 | stx zeroVisible

        lda #10 | sta num | jsr PrintDigitB
        lda value | clc|adc #'0' | tay
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

    ldy ch
    jsr PrintC_
rts


; word PrintNumber5(ptr<byte> pVram, word w);
dseg
PrintNumber5_@Param1 : public PrintNumber5_@Param1
    defw 0
cseg
PrintNumber5_: public PrintNumber5_
    pha
        jsr Locate_
        
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

        lda value | clc|adc #'0' | tay
        jsr PrintC_
    pla
rts
