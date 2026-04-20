ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
PrevSync: defb 0
TimerCount: defb 0 public TimerCount


cseg
    ld a,0 ; Video mode
    call 0bc0eh

    call InitSound
    di
        ld a,0c3h
        ld (38h),a
        ld hl,Handler
        ld (38h+1),hl
    ei

    call InitVram
jp Main_

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
                push hl
                    ld hl,TimerCount
                    inc (hl)
                    call SoundHandler
                pop hl
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
