include "Vram.inc"

ext PrintC_
ext @WB0
ext @WB1

ZeroVisible equ @WB0

cseg
Print:
    push d
        mov e,a
        call PrintC_
    pop d
ret

PrintNumberC:
    if eqi a,'0'
        ex | ldaw ZeroVisible | sui a,0 | ex
        if skz
            mvi a,' '
        endif
    else
        mviw ZeroVisible,1
    endif
    call Print
ret


PrintDigit:
    mvi a,'0'-1
    do
        inr a
        ex
            mov a,e | sub a,c | mov e,a
            mov a,d | sbb a,b | mov d,a
        ex
        skc
    repeat
    ex
        mov a,e | add a,c | mov e,a
        mov a,d | adc a,b | mov d,a
    ex
jmp PrintNumberC


; ptr<byte> PrintNumber5(ptr<byte> pVram, word w);
cseg
PrintNumber5_: public PrintNumber5_
    push v | push d | push b
        mviw ZeroVisible,0

        lxi b,10000
        call PrintDigit
        lxi b,1000
        call PrintDigit
PrintNumber3:
        lxi b,100
        call PrintDigit
        lxi b,10
        call PrintDigit
        mov a,e
        adi a,'0'
        call Print
    pop b | pop d | pop v
ret


; ; ptr<byte> PrintNumber3(ptr<byte> pVram, word w);
; cseg
; PrintNumber3_: public PrintNumber3_
;     push v | push d | push b
;         mviw ZeroVisible,0
;         mviw First,1
;         jr PrintNumber3



PrintDigitB:
    mvi b,'0'-1
    do
        inr b
        sub a,c
        skc
    repeat
    add a,c
    push v
        mov a,b
        call PrintNumberC
    pop v
ret


; ptr<byte> PrintByteNumber3(ptr<byte> pVram, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    push v | push b
        mviw ZeroVisible,0
        mov a,e
        mvi c,100
        call PrintDigitB
        mvi c,10
        call PrintDigitB
        adi a,'0'
        call Print
    pop b | pop v
ret


; ptr<byte> PrintByteNumber2(ptr<byte> pVram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    push v | push b
        mviw ZeroVisible,0
        mov a,e
        mvi c,10
        call PrintDigitB
        adi a,'0'
        call Print
    pop b | pop v
ret
