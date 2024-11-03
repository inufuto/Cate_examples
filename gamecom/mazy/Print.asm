ext PrintC_

cseg
PrintDigitB: public PrintDigitB
    pushw rr0
        mov r1,r3
        mov r3,'0'
        do
            inc r3
            sub r1,r2
        while nc | wend
        add r1,r2
        dec r3
        cmp r3,'0'
        if z
            or r4,r4
            if z
                mov r3,' '
            endif
        else
            mov r4,1
        endif
        mov r2,r1
    popw rr0
    call PrintC_
    mov r3,r2
ret 

; ; word PrintByteNumber3(word yx, byte b);
; cseg
; PrintByteNumber3_: public PrintByteNumber3_
;     pushw rr2 | push r4
;         xor r4,r4
;         mov r2,100
;         call PrintDigitB
;         mov r2,10
;         call PrintDigitB
;         add r3,'0'
;         call PrintC_
;     pop r4 | popw rr2
; ret


; word PrintByteNumber2(word yx, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    pushw rr2 | push r4
        xor r4,r4
        mov r2,10
        call PrintDigitB
        add r3,'0'
        call PrintC_
    pop r4 | popw rr2
ret


cseg
PrintDigit: public PrintDigit
    pushw rr0
        mov r7,'0'
        do
            inc r7
            subw rr2,rr4
        while nc | wend
        addw rr2,rr4
        dec r7
        cmp r7,'0'
        if z
            or r6,r6
            if z
                mov r7,' '
            endif
        else
            mov r6,1
        endif
    popw rr0
    push r3
        mov r3,r7
        call PrintC_
    pop r3
ret 


; word PrintNumber5(word yx, word w);
cseg
PrintNumber5_:public PrintNumber5_
    pushw rr2 | pushw rr4 | pushw rr6
        xor r6,r6
        movw rr4,10000
        call PrintDigit
        movw rr4,1000
        call PrintDigit
        movw rr4,100
        call PrintDigit
        movw rr4,10
        call PrintDigit
        add r3,'0'
        call PrintC_
    popw rr6 | popw rr4 | popw rr2
ret


; word PrintNumber3(word yx, word w);
cseg
PrintNumber3_:public PrintNumber3_
    pushw rr2 | pushw rr4 | pushw rr6
        xor r6,r6
        movw rr4,100
        call PrintDigit
        movw rr4,10
        call PrintDigit
        add r3,'0'
        call PrintC_
    popw rr6 | popw rr4 | popw rr2
ret
