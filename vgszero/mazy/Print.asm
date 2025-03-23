ext PrintC_

cseg

PrintDigit:
    push hl
        ld l,a
        ex de,hl
            xor a
            do
                inc a
                sbc hl,bc
            while nc
            wend
            add hl,bc
            dec a
        ex de,hl
        if z
            dec l
            if nz
                ld a,' '-'0'
            endif
            inc l
        else
            ld l,1
        endif
        add a,'0'
        ld c,l
    pop hl
    push de
        ld e,a
        call PrintC_
    pop de
    ld a,c
ret

PrintNumber5_:
    public PrintNumber5_
; in
;   hl: address
;   de: number
; out
;   hl: next address
    push af
    push de
    push bc
        xor a
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

PrintNumber3_:
    public PrintNumber3_
; in
;   hl: address
;   de: number
; out
;   hl: next address
    push af
    push de
    push bc
        xor a
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


PrintDigitB:
    ld a,e
    ld e,0
    do
        inc e
        sub d
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
    ex af,af'
        ld a,e
        add a,'0'
        ld e,a
    ex af,af'
    call PrintC_
    ld e,a
ret 

; PrintByteNumber3_:
;     public PrintByteNumber3_
; ; in
; ;   hl: address
; ;   e: number
; ; out
; ;   hl: next address
;     push af
;     push de
;     push bc
;         ld c,0
;         ld d,100
;         call PrintDigitB
;         ld d,10
;         call PrintDigitB
;         ld a,e
;         add a,'0'
;         ld e,a
;         call PrintC_
;     pop bc
;     pop de
;     pop af
; ret

PrintByteNumber2_:
    public PrintByteNumber2_
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
