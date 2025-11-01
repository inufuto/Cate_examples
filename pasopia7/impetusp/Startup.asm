ext InitVram
ext InitSound, SoundHandler
ext InitKeys
ext Main_

dseg
TimerCount:
    defb 0 public TimerCount
    
cseg
    call InitKeys
    call InitSound
    call InitVram

    ld hl,KeyInt
    ld (0fefah),hl

    ld hl,Handler
    ld (0fef6h),hl
    ei
jp Main_


KeyInt:
    ei
reti

Handler: public Handler
    push af | push hl
        ld hl,TimerCount
        inc (hl)
        call SoundHandler
    pop hl | pop af
    ei
reti

WaitTimer_:
    public WaitTimer_
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
