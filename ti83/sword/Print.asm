ext PrintC_


dseg
first:
    defb 0
right:
    defb 0

cseg
PrintByteNumberC_: public PrintByteNumberC_
    push af | push bc
        ld a,(right) | ld c,a
        xor 1 | ld (right),a
        call PrintC_
    pop bc | pop af
ret


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
        cp ' '
        jr nz,pout
        ld a,(first)
        or a
        if nz
            xor a | ld (first),a
            ld a,' '
            pout:
            ld e,a
            call PrintByteNumberC_
        endif
    pop de
    ld a,c
ret


; ptr<byte> PrintNumber5(ptr<byte> pVram, word w, bool right);
cseg
PrintNumber5_: public PrintNumber5_
    push af | push de | push bc
        ld a,1 | ld (first),a
        ld a,c | ld (right),a
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
        call PrintByteNumberC_
    pop bc | pop de | pop af
ret


; ; ptr<byte> PrintNumber3(ptr<byte> pVram, word w, bool right);
; PrintNumber3_: public PrintNumber3_
;     push af | push de | push bc
;         ld a,1 | ld (first),a
;         ld a,c | ld (right),a
;         xor a
;         ld bc,100
;         call PrintDigit
;         ld bc,10
;         call PrintDigit
;         ld a,e
;         add a,'0'
;         ld e,a
;         call PrintByteNumberC_
;     pop bc | pop de | pop af
; ret


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
        cp ' '
        jr nz,pbout
        ld a,(first)
        or a
        if nz
            xor a | ld (first),a
            ld a,' '
            pbout:
            ld e,a
            call PrintByteNumberC_
        endif
    ex af,af'
    ld e,a
ret 


; ptr<byte> PrintByteNumber3(ptr<byte> pVram, byte b, bool right);
PrintByteNumber3_: public PrintByteNumber3_
    push af | push de | push bc
        ld a,1 | ld (first),a
        ld a,c | ld (right),a
        ld c,0
        ld d,100
        call PrintDigitB
        ld d,10
        call PrintDigitB
        ld a,e
        add a,'0'
        ld e,a
        call PrintByteNumberC_
    pop bc | pop de | pop af
ret


; ptr<byte> PrintByteNumber2(ptr<byte> pVram, byte b, bool right);
PrintByteNumber2_: public PrintByteNumber2_
    push af | push de | push bc
        ld a,1 | ld (first),a
        ld a,c | ld (right),a
        ld c,0
        ld d,10
        call PrintDigitB
        ld a,e
        add a,'0'
        ld e,a
        call PrintByteNumberC_
    pop bc | pop de | pop af
ret
