include "FixedCode.inc"

ext FixedCode, InitVram
ext InitSound, SoundHandler
ext InitKeys
ext Main_

Interval equ 2000000/60

dseg
TimerCount:
    defb 0 
    
cseg
    in a,(29h)
    or 80h
    out (29h),a

    ld hl,FixedCode
    ld de,FixedCode_start
    ld bc,FixedCode_size
    ldir

    call InitSound
    call InitKeys
    call InitVram
    di
        ld hl,Handler
        ld (0f02ah),hl

        xor a
        ld (TimerCount),a

        in a,(2dh)
        and 0dfh
        out (2dh),a

        ld a,low Interval | out (25h),a
        ld a,high Interval | out (25h),a
    ei
jp Main_


cseg
Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
    call SoundHandler
    ld a,5
ret


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
