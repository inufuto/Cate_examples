ext PrintC_, PrintC_@Param0, PrintC_@Param1

dseg
zeroVisible:
    defb 0
value:
    defw 0
num:
    defw 0
count:
    defb 0
pVram:
    defw 0

cseg
PrintDigitB:
    clrb
    ldaa value
    do
        suba num
    while cc
        incb
    wend
    adda num
    staa value
    tstb
    if eq
        tst zeroVisible
        if ne
            ldab #'0'
        else
            ldab #' '
        endif
    else
        inc zeroVisible
        addb #'0'
    endif
    ldx pVram
    stx PrintC_@Param0
    stab PrintC_@Param1
    jsr PrintC_
    stx pVram
rts

; word PrintByteNumber2(word vram, byte b);
dseg
PrintByteNumber2_@Param0 : public PrintByteNumber2_@Param0
    defw 0
PrintByteNumber2_@Param1 : public PrintByteNumber2_@Param1
    defb 0
cseg
PrintByteNumber2_: public PrintByteNumber2_
    psha | pshb
        ldx PrintByteNumber2_@Param0 | stx pVram

        clr zeroVisible
        ldab PrintByteNumber2_@Param1 | stab value

        ldaa #10 | staa num
        bsr PrintDigitB
        ldab value | addb #'0' | stab PrintC_@Param1
        ldx pVram | stx PrintC_@Param0
        jsr PrintC_
    pulb | pula
rts


; word PrintByteNumber3(word vram, byte b);
dseg
PrintByteNumber3_@Param0 : public PrintByteNumber3_@Param0
    defw 0
PrintByteNumber3_@Param1 : public PrintByteNumber3_@Param1
    defb 0
cseg
PrintByteNumber3_: public PrintByteNumber3_
    psha | pshb
        ldx PrintByteNumber3_@Param0 | stx pVram

        clr zeroVisible
        ldab PrintByteNumber3_@Param1 | stab value

        ldaa #100 | staa num
        bsr PrintDigitB
        ldaa #10 | staa num
        bsr PrintDigitB
        ldab value | addb #'0' | stab PrintC_@Param1
        ldx pVram | stx PrintC_@Param0
        jsr PrintC_
    pulb | pula
rts


cseg
PrintDigitW:
    clr count
    do
        ldaa value+1 | suba num+1 | staa value+1
        ldaa value | sbca num | staa value
    while cc
        inc count
    wend
    ldaa value+1 | adda num+1 | staa value+1
    ldaa value | adca num | staa value

    ldab count
    if eq
        tst zeroVisible
        if ne
            ldab #'0'
        else
            ldab #' '
        endif
    else
        inc zeroVisible
        addb #'0'
    endif
    ldx pVram
    stx PrintC_@Param0
    stab PrintC_@Param1
    jsr PrintC_
    stx pVram
rts


; word PrintNumber5(word vram, word w);
dseg
PrintNumber5_@Param0 : public PrintNumber5_@Param0
    defw 0
PrintNumber5_@Param1 : public PrintNumber5_@Param1
    defw 0
cseg
PrintNumber5_: public PrintNumber5_
    psha | pshb
        ldx PrintNumber5_@Param0 | stx pVram
        ldx PrintNumber5_@Param1 | stx value

        clr zeroVisible

        ldx #10000 | stx num
        bsr PrintDigitW
        ldx #1000 | stx num
        bsr PrintDigitW
        ldx #100 | stx num
        bsr PrintDigitW
        ldx #10 | stx num
        bsr PrintDigitW
        ldab value+1 | addb #'0' | stab PrintC_@Param1
        ldx pVram | stx PrintC_@Param0
        jsr PrintC_
    pulb | pula
rts
