ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: defb 0 public TimerCount
SoundDiv: defb 0

cseg
    di
        ld a,0fbh | ld (0ed1ch),a | out (0c1h),a ; CRT mode
        xor a | ld (0ed1eh),a | out (0c9h),a ; display page
        ld a,2 | ld (0ed1dh),a
    ei
    ld a,04h | out (0b0h),a
    ld a,0ah | out (0c0h),a
    xor a | out (0cfh),a

    xor a
    ld (0e6cdh),a ; click
    ld (TimerCount),a
    ld (SoundDiv),a

    call InitSound
    call InitVram

    di
        ld hl,(0e606h) ; interrupt handler
        ld (Handler_end+1),hl
        ld hl,Handler
        ld (0e606h),hl
    ei
jp Main_

Handler: public Handler
    push af | push hl
        ld hl,SoundDiv
        dec (hl)
        if z
            ld (hl),10
            ld hl,TimerCount
            inc (hl)
            call SoundHandler
        endif
    pop hl | pop af
Handler_end:
    jp 0


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
