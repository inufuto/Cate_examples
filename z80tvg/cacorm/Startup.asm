ext Main_

cseg
    di
    
    ld hl,8000h
    ld bc,2000h
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
    ld sp,0a000h

    ld a,90h | out (03h),a
    ld a,0aah | out (01h),a
    in a,(01h)
    cp 0aah
    if nz
        StartupPIO:
        ld a,4fh | out (01h),a
        ld a,0fh | out (03h),a
    else
        ld a,55h | out (01h),a
        in a,(01h)
        cp 55h
        jr nz,StartupPIO
    endif
    ext CallSound_ ,Sound_Hit_
    call Sound_Hit_
    call CallSound_
jp Main_


; void Wait(byte t);
cseg
Wait_: public Wait_
    push af | push de | push bc
        ld e,a
        do
            ld bc,1000
            do
                dec bc
                ld a,c | or b
            while nz | wend
            dec e
        while nz | wend
    pop bc | pop de | pop af
ret
