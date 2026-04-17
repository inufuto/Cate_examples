ext InitVram
ext ClearScreen_
ext InitSound, SoundHandler
ext Main_

interrupt_interval equ 15625/60/10/2

dseg
TimerCount: public TimerCount
    defb 0
OldBlank:
    defb 0
denom:
    defb 0

cseg
    ld sp,8000h
    out (0e0h),a
    ld a,00h | out (0ceh),a

    call InitVram
    call InitSound                                            
    di
        ld a,0c3h | ld (38h),a
        ld hl,Handler | ld (38h+1),hl

        im 1
        ld a,0b0h | out (0d7h),a
        ld a,74h | out (0d7h),a
        ld a,1+1 | out (0d6h),a
        xor a | out (0d6h),a
        ld a,low interrupt_interval | out (0d5h),a
        ld a,high interrupt_interval | out (0d5h),a

        in a,(0d2h)
        or 04h
        out (0d2h),a

        xor a | ld (denom),a | ld (OldBlank),a
    ei
jp Main_


Handler: public Handler
    push af | push hl
        in a,(0feh)
        and 20h
        if z
            ld a,(OldBlank)
            or a
            if nz
                ld a,(denom)
                sub 6
                do | while m
                    push af
                        ld hl,TimerCount
                        inc (hl)
                        call SoundHandler
                    pop af
                    add a,5
                wend
                ld (denom),a
                xor a
            endif
        endif
        ld (OldBlank),a

        ld a,1+1 | out (0d6h),a
        xor a | out (0d6h),a
    pop hl | pop af
    ei
ret
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
