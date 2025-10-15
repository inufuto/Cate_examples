ext InitVram_
ext InitSound_, SoundHandler
ext Main_
extrn InitKeys

dseg
TimerCount: public TimerCount
    defb 0
PrevSync:
    defb 0

cseg
    di
    ld a,(0f91fh)
    and 0fh
    or 90h
    ld (0f91fh),a
    out (40h),a

    xor a
    ld (PrevSync),a
    ld (TimerCount),a
    call InitKeys
    call InitVram_
    call InitSound_
jp Main_


PollVSync_: public PollVSync_
    push af
        in a,(40h)
        and 10h
        if z
            ld a,(PrevSync)
            or a
            call nz,Handler
            xor a
        endif
        ld (PrevSync),a
    pop af
ret


Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
jp SoundHandler


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollVSync_
            ld a,(TimerCount)
            cp e
        while c | wend
        xor a
        ld (TimerCount),a
    pop de | pop af
ret
