ext PrintC_

; dseg
; first:
;     defb 0

cseg
PrintDigit:
    push hl
        ld h,a ; zero
        ld l,0 ; count
        do
            inc l
            ld a,e | sub a,c | ld e,a
            ld a,d | sbc a,b | ld d,a
        while nc | wend
        dec l
        ld a,e | add a,c | ld e,a
        ld a,d | adc a,b | ld d,a
        ld a,l
        or a,a
        if z
            ld a,h
            or a,a
            if z
                ld a,l
                ld a,' '-'0'
                ld l,a
            endif
        else
            ld h,1
        endif
        ld a,l
        add a,'0'
        ld c,h
    pop hl
    push de
		ld e,a
		call PrintC_
    pop de
    ld a,c
ret

PrintNumber5_: public PrintNumber5_
; in
;   hl: address
;   de: number
; out
;   hl: next address
    push af
    push de
    push bc
        xor a,a
        ld bc,10000
        call PrintDigit
        ld bc,1000
        call PrintDigit
        PrintNumber3:
        ld bc,100
        call PrintDigit
        ld bc,10
        call PrintDigit
        ld a,e
        add a,'0'
        ld e,a
        call PrintC_
    pop bc
    pop de
    pop af
ret

; PrintNumber3_: public PrintNumber3_
; ; in
; ;   hl: address
; ;   de: number
; ; out
; ;   hl: next address
;     push af
;     push de
;     push bc
;         ld a,1 | sta first
;         xor a,a
;         ld bc,100
;         call PrintDigit
;         ld bc,10
;         call PrintDigit
;         ld a,e
;         add a,'0'
;         ld e,a
;         call PrintC_
;     pop bc
;     pop de
;     pop af
; ret


PrintDigitB:
    ld a,e
    ld e,0
    do
        inc e
        sub a,d
    while nc
    wend
    add a,d
    dec e
    if z
        dec c
        if nz
            ld e,' '-'0'
        endif
        inc c
    else
        ld c,1
    endif
    ld d,a
        ld a,e
        add a,'0'
		ld e,a
		call PrintC_
    ld e,d
ret 

PrintByteNumber3_: public PrintByteNumber3_
; in
;   hl: address
;   e: number
; out
;   hl: next address
    push af | push de | push bc
        ld c,0
        ld d,100
        call PrintDigitB
        ld d,10
        call PrintDigitB
        ld a,e
            add a,'0'
        ld e,a
        call PrintC_
    pop bc | pop de | pop af
ret

PrintByteNumber2_: public PrintByteNumber2_
; in
;   hl: address
;   e: number
; out
;   hl: next address
    push af
    push de
        ld c,0
        ld d,10
        call PrintDigitB
        ld a,e
        add a,'0'
        ld e,a
        call PrintC_
    pop de
    pop af
ret
