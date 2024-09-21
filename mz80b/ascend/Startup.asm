ext InitVram_, InitSound_, Main_

Text equ 0d000h

    cseg
    ld hl,0c000h
    ld sp,hl

    ld a,2
    out (0f4h),a

    ld a,80h
    out (0e8h),a

    ld hl,Text
    ld bc,1000
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
    call InitVram_
    call InitSound_
jp Main_


Wait_ : public Wait_
    push af | push bc
        ld bc, 4000
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop af
ret
