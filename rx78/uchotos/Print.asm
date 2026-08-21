ext PrintC_, Locate_

dseg
first:
    defb 0

; void PrintS(word vram, bool shift, ptr<byte> p);
cseg
PrintS_: public PrintS_
    push af | push bc
        call Locate_
        do
            ld a,(bc) | inc bc
            or a
        while nz
            call PrintC_
        wend
    pop bc | pop af
ret


cseg
PrintDigitW:
    xor a
    do
        inc a
        sbc hl,bc
    while nc
    wend
    add hl,bc
    dec a
    if z
        dec e
        if nz
            ld a,' '-'0'
        endif
        inc e
    else
        ld e,1
    endif
    add a,'0'
    cp ' '
    jr nz,pout
    ld a,(first)
    or a
    if nz
        xor a | ld (first),a
        ld a,' '
        pout:
        call PrintC_
    endif
ret


; void PrintNumber5(word vram, bool shift, word w);
cseg
PrintNumber5_: public PrintNumber5_
    push af | push hl | push de | push bc
        ld a,1 | ld (first),a
        call Locate_
        ld l,c | ld h,b
        ld e,0
        ld bc,10000
        call PrintDigitW
        ld bc,1000
        call PrintDigitW
        PrintNumber3:
        ld bc,100
        call PrintDigitW
        ld bc,10
        call PrintDigitW
        ld a,l
        add a,'0'
        call PrintC_
    pop bc | pop de |  pop hl | pop af
ret


cseg
PrintDigitB: public PrintDigitB
    ld c,0
    do
        inc c
        sub e
    while nc
    wend
    add a,e
    dec c
    if z
        dec d
        if nz
            ld c,' '-'0'
        endif
        inc d
    else
        ld d,1
    endif
    ld e,a
    ld a,c
    add a,'0'
    cp ' '
    jr nz,pbout
    ld a,(first)
    or a
    if nz
        xor a | ld (first),a
        ld a,' '
        pbout:
        call PrintC_
    endif
    ld a,e
ret 


; void PrintByteNumber3(word vram, bool shift, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    push af | push hl | push de | push bc
        ld a,1 | ld (first),a
        call Locate_
        ld a,c
        ld d,0
        ld e,100
        call PrintDigitB
        ld e,10
        call PrintDigitB
        add a,'0'
        call PrintC_
    pop bc | pop de |  pop hl | pop af
ret


; void PrintByteNumber2(word vram, bool shift, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    push af | push hl | push de | push bc
        ld a,1 | ld (first),a
        call Locate_
        ld a,c
        ld d,0
        ld e,10
        call PrintDigitB
        add a,'0'
        call PrintC_
    pop bc | pop de |  pop hl | pop af
ret
