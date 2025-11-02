ext InitVram
ext InitSound, SoundHandler
ext InitKeys
ext Main_

dseg
TimerCount:
    defb 0 public TimerCount


cseg
    call InitSound
    call InitKeys

    ; width 40 ; 320*200 4bpp
    ld a,84h
    out (20h),a

    ; hide cursor
    ld a,10
    out (18h),a
    ld a,0ffh
    out (19h),a
    ld a,11
    out (18h),a
    ld a,0ffh
    out (19h),a

    call InitVram

    di
        im 1

        ld a,0c3h
        ld (38h),a
        ld hl,Handler
        ld (38h+1),hl

        ; enable timer
        ld a,1
        out (21h),a
    ei
jp Main_



    cseg
Handler: public Handler
    push af
        ld a,(TimerCount)
        inc a
        ld (TimerCount),a
        call SoundHandler
    pop af
    ei
ret
; Handler_end:
;     jp 0


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        di
            xor a | ld (TimerCount),a
        ei
    pop de | pop af
ret
