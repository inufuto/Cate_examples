ext SoundHandler
ext InitVram_, InitSound_

dseg
PrevSync: defb 0
; rateValue: defb 0
TimerCount: defb 0 public TimerCount


cseg
Init_: public  Init_
    push af | push hl
        ld a,1
        call 0bc0eh

        call InitSound_
        ; xor a | ld (rateValue),a
        di
            ld a,0c3h
            ld (38h),a
            ld hl,Handler
            ld (38h+1),hl
        ei

        ld bc,7f10h | out (c),c
        ld a,54h | out (c),a
        ld bc,7f00h | out (c),c
        ld a,54h | out (c),a
        ld bc,7f01h | out (c),c
        ld a,45h | out (c),a
        ld bc,7f02h | out (c),c
        ld a,57h | out (c),a
        ld bc,7f03h | out (c),c
        ld a,4bh | out (c),a

        call InitVram_
    pop hl | pop af
ret


Handler: public Handler
    push af
        push bc
            ld bc,0f500h
            in a,(c)
        pop bc
        and 1
        if nz
            ld a,(PrevSync)
            or a
            if z
                ; do
                ;     ld a,(rateValue)
                ;     or a
                ; while p
                ;     sub 5
                ;     ld (rateValue),a
                    push hl
                        ld hl,TimerCount
                        inc (hl)
                        call SoundHandler
                    pop hl
                ; wend
                ; add a,6
                ; ld (rateValue),a
            endif
            ld a,1
        endif
        ld (PrevSync),a
    pop af
    ei
reti


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        di
            xor a
            ld (TimerCount),a
        ei
    pop de | pop af
ret
