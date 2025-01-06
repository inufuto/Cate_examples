ext InitColors
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: defb 0 public TimerCount


cseg
    defb 1,0,0
    ;ld sp,0ec00h
    ;im 1
    
    call InitSound
    di
        ld hl,Handler
        ld (0e788h),hl

        xor a
        out (0f3h),a
        ld a,0c1h
        out (0f3h),a
    ei
    im 1
    ld a,02h ; Allocate VRAM page 4-6 to normal memory (0B000h-)
    out (0efh),a
    
    ld a,010h
    out (0f4h),a
    
    ld a,07h
    out (0feh),a

    call InitColors
jp Main_


Handler: public Handler
    di
    push af | push hl | push de | push bc
        ld a,81h
        out (0f3h),a
        ld a,0c1h
        out (0f3h),a
    
        call SoundHandler
        ld hl,TimerCount
        inc (hl)
    pop bc | pop de | pop hl | pop af
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
