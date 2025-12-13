ext PrintC_

cseg
PrintDigit:
    ld qhl,0
    div xhl,bc
    ld c,l
    ld hl,qhl
    or c,c
    if z
        or e,e
        if z
            ld c,' '
            jr PrintDigit_print
        endif
    endif
    inc 1,e
    add c,'0'
    PrintDigit_print:
    call PrintC_
ret

; extern word PrintNumber5(word vram, word w);
cseg
PrintNumber5_: public PrintNumber5_
    push bc | push e | push xhl
        xor e,e ; zeroVisible
        ld hl,bc
        ld bc,10000
        call PrintDigit
        ld bc,1000
        call PrintDigit
        ld bc,100
        call PrintDigit
        ld bc,10
        call PrintDigit
        ld c,l
        add c,'0'
        call PrintC_
    pop xhl | pop e | pop bc
ret


cseg
PrintDigitB:
    xor h,h
    div hl,c
    ld c,l
    ld l,h
    or c,c
    if z
        or b,b
        if z
            ld c,' '
            jr PrintDigitB_print
        endif
    endif
    inc 1,b
    add c,'0'
    PrintDigitB_print:
    call PrintC_
ret

; word PrintByteNumber3(word vram, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    push bc | push hl
        xor b,b ; zeroVisible
        ld l,c
        ld c,100
        call PrintDigitB
        ld c,10
        call PrintDigitB
        ld c,l
        add c,'0'
        call PrintC_
    pop hl | pop bc
ret

; word PrintByteNumber2(word vram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    push bc | push hl
        xor b,b ; zeroVisible
        ld l,c
        ld c,10
        call PrintDigitB
        ld c,l
        add c,'0'
        call PrintC_
    pop hl | pop bc
ret
