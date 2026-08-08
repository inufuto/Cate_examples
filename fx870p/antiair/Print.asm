ext PrintC_

cseg
PrintDigitB:
    ld $0,$sx
    do
        sb $1,$2
    while nc
        ad $0,$sy
    wend
    ad $1,$2
    sbc $0,$sx
    if z
        sbc $3,$sx
        if nz
            ad $0,'0'
        else
            ad $0,' '
        endif
    else
        ld $3,$sy
        ad $0,'0'
    endif
    phs $1
        ld $1,$0
        cal PrintC_
    pps $1
rtn

; word PrintByteNumber3(word vram, byte b);
PrintByteNumber3_: public PrintByteNumber3_
    phsm $3,4
        ld $3,$sx ; zeroVisible
        ld $2,100 | cal PrintDigitB
        ld $2,10 | cal PrintDigitB
        ad $1,'0'
        cal PrintC_
    ppsm $0,4
rtn


; word PrintByteNumber2(word vram, byte b);
PrintByteNumber2_: public PrintByteNumber2_
    phsm $3,4
        ld $0,$sx ; zeroVisible
        ld $2,10 | cal PrintDigitB
        ad $1,'0'
        cal PrintC_
    ppsm $0,4
rtn


cseg
PrintDigitW:
    ld $1,$sx
    do
        sbw $12,$14
    while nc
        ad $1,$sy
    wend
    adw $12,$14
    sbc $1,$sx
    if z
        sbc $0,$sx
        if nz
            ad $1,'0'
        else
            ad $1,' '
        endif
    else
        ld $0,$sy
        ad $1,'0'
    endif
    cal PrintC_
rtn


; word PrintNumber5(ptr<byte> address, word w);
PrintNumber5_: public PrintNumber5_
    phsm $1,2
    phsm $14,4
        ld $0,$sx ; zeroVisible
        ldw $14,10000 | cal PrintDigitW
        ldw $14,1000 | cal PrintDigitW
        ldw $14,100 | cal PrintDigitW
        ldw $14,10 | cal PrintDigitW
        ld $1,$12
        ad $1,'0'
        cal PrintC_
    ppsm $12,4
    ppsm $0,2
rtn


; ; word PrintNumber3(ptr<byte> address, word w);
; PrintNumber3_: public PrintNumber3_
;     phsm $1,2
;     phsm $14,4
;         ld $0,$sx ; zeroVisible
;         ld $14,100 | cal PrintDigitW
;         ld $14,10 | cal PrintDigitW
;         ld $1,$12
;         ad $1,'0'
;         cal PrintC_
;     ppsm $12,4
;     ppsm $0,2
; rtn
