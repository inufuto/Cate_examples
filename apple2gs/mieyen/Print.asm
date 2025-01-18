include "apple2.inc"
include "apple2gs.inc"
include "Zeropage.inc"
include "Vram.inc"

ext PrintC_

PrintC_vram equ @zp+0
PrintC_c equ @zp+2
ValueParam equ @zp+2

zeroVisible:
    defb 0
value:
    defw 0
num:
    defw 0
; pVram:
;     defw 0

cseg
PrintDigitB:
    a8
    lda #'0' | sta <PrintC_c

    lda value
    do
        sec|sbc num
    while cs
        inc <PrintC_c
    wend
    clc|adc num
    sta value

    lda <PrintC_c
    cmp #'0'
    if eq
        lda zeroVisible
        if eq
            lda #' ' | sta <PrintC_c
        endif
    else
        inc zeroVisible
    endif

    rep #$20 | a16
    jsr PrintC_
    sep #$20 | a8
rts

; word PrintByteNumber3(word vram, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    php
        sep #$20 | a8
        lda <ValueParam | sta value
        stz zeroVisible

        lda #100 | sta num | jsr PrintDigitB
        lda #10 | sta num | jsr PrintDigitB

        lda value | clc|adc #'0' | sta <PrintC_c
        jsr PrintC_
    plp
rts


; word PrintByteNumber2(word vram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    php
        sep #$20 | a8
        lda <ValueParam | sta value
        stz zeroVisible

        lda #10 | sta num | jsr PrintDigitB

        lda value | clc|adc #'0' | sta <PrintC_c
        jsr PrintC_
    plp
rts


cseg
PrintDigit:
    sep #$20 | a8
    lda #'0' | sta <PrintC_c

    rep #$20 | a16
    lda value
    do
        sec|sbc num
    while cs
        sep #$20 | a8
        inc <PrintC_c
        rep #$20 | a16
    wend
    clc|adc num
    sta value

    sep #$20 | a8
    lda <PrintC_c
    cmp #'0'
    if eq
        lda zeroVisible
        if eq
            lda #' ' | sta <PrintC_c
        endif
    else
        inc zeroVisible
    endif
    jsr PrintC_
    rep #$20 | a16
rts


; word word PrintNumber5(word vram, word w);
cseg
PrintNumber5_: public PrintNumber5_
    php
        lda <ValueParam | sta value
        sep #$20 | a8
        stz zeroVisible

        rep #$20 | a16
        lda #10000 | sta num | jsr PrintDigit
        lda #1000 | sta num | jsr PrintDigit
        lda #100 | sta num | jsr PrintDigit
        lda #10 | sta num | jsr PrintDigit

        sep #$20 | a8
        lda value | clc|adc #'0' | sta <PrintC_c
        jsr PrintC_
    plp
rts
