ext PrintC_

; dseg
; first:
;     defb 0

cseg

SubHlBc:
    mov a,l
    sub c
    mov l,a
    mov a,h
    sbb b
    mov h,a
ret

PrintDigit:
    push h
        mov l,a
        xchg
            push d
                mvi e,0
                do
                    inr e
                    call SubHlBc
                while nc
                wend
                dad b
                dcr e
                mov a,e
            pop d
        xchg
        if z
            dcr l
            if nz
                mvi a,' '-'0'
            endif
            inr l
        else
            mvi l,1
        endif
        adi '0'
        mov c,l
    pop h
    push d
		mov e,a
		call PrintC_
    pop d
    mov a,c
ret

PrintNumber5_: public PrintNumber5_
; in
;   hl: address
;   de: number
; out
;   hl: next address
    push psw
    push d
    push b
        xra a
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
        adi '0'
        mov e,a
        call PrintC_
    pop b
    pop d
    pop psw
ret

; PrintNumber3_: public PrintNumber3_
; ; in
; ;   hl: address
; ;   de: number
; ; out
; ;   hl: next address
;     push psw
;     push d
;     push b
;         mvi a,1 | sta first
;         xra a
;         lxi b,100
;         call PrintDigit
;         lxi b,10
;         call PrintDigit
;         mov a,e
;         adi '0'
;         mov e,a
;         call PrintC_
;     pop b
;     pop d
;     pop psw
; ret


PrintDigitB:
    mov a,e
    mvi e,0
    do
        inr e
        sub d
    while nc
    wend
    add d
    dcr e
    if z
        dcr c
        if nz
            mvi e,' '-'0'
        endif
        inr c
    else
        mvi c,1
    endif
    mov d,a
        mov a,e
        adi '0'
		mov e,a
		call PrintC_
    mov e,d
ret 

PrintByteNumber3_: public PrintByteNumber3_
; in
;   hl: address
;   e: number
; out
;   hl: next address
    push psw | push d | push b
        mvi c,0
        mvi d,100
        call PrintDigitB
        mvi d,10
        call PrintDigitB
        mov a,e
            adi '0'
        mov e,a
        call PrintC_
    pop b | pop d | pop psw
ret

PrintByteNumber2_: public PrintByteNumber2_
; in
;   hl: address
;   e: number
; out
;   hl: next address
    push psw
    push d
        mvi c,0
        mvi d,10
        call PrintDigitB
        mov a,e
        adi '0'
        mov e,a
        call PrintC_
    pop d
    pop psw
ret
