ext PrintC_

dseg
zeroVisible:
    defb 0
value:
    defw 0

zseg
num:
    defw 0
count:
    defb 0


cseg
PrintDigitB:
    clrb
    lda value
    do
        suba <num
    while cc
        incb
    wend
    adda <num
    sta value
    tstb
    if eq
        tst zeroVisible
        if ne
            ldb #'0'
        else
            ldb #' '
        endif
    else
        inc zeroVisible
        addb #'0'
    endif
    jsr PrintC_
    tfr d,x
rts


; word PrintByteNumber3(word vram, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    pshs a,b
        clr zeroVisible
        stb value

        lda #100 | sta <num
        bsr PrintDigitB
        lda #10 | sta <num
        bsr PrintDigitB
        ldb value | addb #'0'
        jsr PrintC_
    puls a,b
rts


; word PrintByteNumber2(word vram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pshs x
        clr zeroVisible
        stb value

        lda #10 | sta <num
        bsr PrintDigitB
        ldb value | addb #'0'
        jsr PrintC_
    puls x
rts


cseg
PrintDigitW:
    clr <count
    ldd value
    do
        subd <num
    while cc
        inc <count
    wend
    addd <num
    std value
    ldb <count
    if eq
        tst zeroVisible
        if ne
            ldb #'0'
        else
            ldb #' '
        endif
    else
        inc zeroVisible
        addb #'0'
    endif
    jsr PrintC_
    tfr d,x
rts


; word PrintNumber5(word vram, word w);
PrintNumber5_: public PrintNumber5_
    pshs x,y
        clr zeroVisible
        sty value

        ldd #10000 | std <num
        bsr PrintDigitW
        ldd #1000 | std <num
        bsr PrintDigitW
        ldd #100 | std <num
        bsr PrintDigitW
        ldd #10 | std <num
        bsr PrintDigitW
        ldb value+1 | addb #'0'
        jsr PrintC_
    puls x,y
rts


; word PrintNumber3(word vram, word w);
PrintNumber3_: public PrintNumber3_
    pshs x,y
        clr zeroVisible
        sty value

        ldd #100 | std <num
        bsr PrintDigitW
        ldd #10 | std <num
        bsr PrintDigitW
        ldb value+1 | addb #'0'
        jsr PrintC_
    puls x,y
rts
