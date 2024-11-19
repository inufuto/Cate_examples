include "InternalRam.inc"

ext PrintC_

cseg
PrintDigitB:
    lii 0
    lp RegisterB
    do
        sbm
    while nc
        inci
    wend
    adm
PrintI:
    lp RegisterI|ldm
    cpia 0
    if z
        incj|decj ; zeroVisible
        if nz
            lia '0'
        else
            lia ' '
        endif
    else
        lij 1 ; zeroVisible
        adia '0'
    endif
    exab
    call PrintC_
    exab
rtn
PrintLastB:
    exab
    adia '0'
    exab
jp PrintC_
PrintDigit:
    lii 0
    do
        lp RegisterY | sbb
    while nc
        inci
    wend
    lp RegisterY | adb
jr PrintI
PrintLast:
    lp RegisterY|ldm
    adia '0'
    exab
jp PrintC_


; ptr<byte> PrintByteNumber2(ptr<byte> address, byte b);
PrintByteNumber2_: public PrintByteNumber2_
    push
    exab|push|exab
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
        lij 0 ; zeroVisible
        lia 10 | call PrintDigitB
        call PrintLastB
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    exab|pop|exab
    pop
rtn


; ptr<byte> PrintByteNumber3(ptr<byte> address, byte b);
PrintByteNumber3_: public PrintByteNumber3_
    push
    exab|push|exab
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
        lij 0 ; zeroVisible
        lia 100 | call PrintDigitB
        lia 10 | call PrintDigitB
        call PrintLastB
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    exab|pop|exab
    pop
rtn


; ptr<byte> PrintNumber3(ptr<byte> address, word w);
PrintNumber3_: public PrintNumber3_
    push
    exab|push|exab
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
        lij 0 ; zeroVisible
        lia low 100
        lib high 100
        call PrintDigit
        lia low 10
        lib high 10
        call PrintDigit
        call PrintLast
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    exab|pop|exab
    pop
rtn


; ptr<byte> PrintNumber5(ptr<byte> address, word w);
PrintNumber5_: public PrintNumber5_
    push
    exab|push|exab
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
        lij 0 ; zeroVisible
        lia low 10000
        lib high 10000
        call PrintDigit
        lia low 1000
        lib high 1000
        call PrintDigit
        lia low 100
        lib high 100
        call PrintDigit
        lia low 10
        lib high 10
        call PrintDigit
        call PrintLast
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    exab|pop|exab
    pop
rtn
