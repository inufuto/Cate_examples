    extrn entry

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
jp entry
