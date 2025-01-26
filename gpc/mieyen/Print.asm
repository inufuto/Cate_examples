include "Vram.inc"

ext Ascii_
ext PrintC_

ext @WB0

ZeroVisible equ @WB0
zseg
First:
    defb 0
cseg


PrintC:
    push d
        mov e,a
        call PrintC_
    pop d
ret


PrintNumberC:
    if eqi a,'0'
        push v
            ldaw ZeroVisible | sui a,0
        pop v
        if sknz
        else
            ldaw First
            if nei a,0
                ret
            endif
            xra a,a | staw First
            mvi a,' '
        endif
    else
        push v
            mvi a,1
            staw ZeroVisible
        pop v
    endif
jmp PrintC


PrintDigit:
    mvi a,'0'-1
    do
        inr a
        push v
            mov a,e
            sub a,c
            mov e,a
            mov a,d
            sbb a,b
            mov d,a
        pop v
        sknc | eqa a,a
    repeat
    push v
        mov a,e
        add a,c
        mov e,a
        mov a,d
        adc a,b
        mov d,a
    pop v
jmp PrintNumberC


; ptr<byte> PrintNumber5(ptr<byte> pVram, word w);
cseg
PrintNumber5_: public PrintNumber5_
    push v | push b
        xra a,a | staw ZeroVisible
        inr a | staw First

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
        call PrintC
    pop b | pop v
ret


; ; ptr<byte> PrintNumber3(ptr<byte> pVram, word w);
; cseg
; PrintNumber3_: public PrintNumber3_
;     push v | push b
;         xra a,a | staw ZeroVisible
;         inr a | staw First
;         jr PrintNumber3



PrintDigitB:
    mvi b,'0'-1
    do
        inr b
        sub a,c
        sknc | eqa a,a
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
        xra a,a | staw ZeroVisible
        inr a | staw First
        mov a,e
        mvi c,100
        call PrintDigitB
        mvi c,10
        call PrintDigitB
        adi a,'0'
        call PrintC
    pop b | pop v
ret


; ptr<byte> PrintByteNumber2(ptr<byte> pVram, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    push v | push b
        xra a,a | staw ZeroVisible
        inr a | staw First
        mov a,e
        mvi c,10
        call PrintDigitB
        adi a,'0'
        call PrintC
    pop b | pop v
ret
