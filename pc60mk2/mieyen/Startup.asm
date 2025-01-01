ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: defb 0 public TimerCount
SoundDiv: defb 0

cseg
Init_:
 public  Init_
    ld a,05h | out (0c1h),a
    ld a,04h | out (0b0h),a
    ld a,0ah | out (0c0h),a
    ld a,08h | out (0c1h),a

    xor a
    ld (0fa2dh),a ; click
    ld (TimerCount),a
    ld (SoundDiv),a

    call InitSound
    call InitVram

    di
        ld hl,(0FA06h) ; interrupt handler
        ld (Handler_end+1),hl
        ld hl,Handler
        ld (0FA06h),hl
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
