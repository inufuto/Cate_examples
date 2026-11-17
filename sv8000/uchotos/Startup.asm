include "sv8000.inc"

ext InitVram
ext InitSound,SoundHandler
ext Main_

dseg
TimerCount: public TimerCount
    defb 0

cseg
    im 1
    ld sp,8400h

    ld bc,4000h
    do
        dec bc
        ld a,c | or b
    while nz | wend

    ld a,92h | out (PpiControlPort),a
    call InitVram
    call InitSound

    ei
jp Main_

defs 1dh

Handler: public Handler
    push af
        push hl
            ld hl,TimerCount
            inc (hl)
        pop hl
        call SoundHandler
    pop af
ei
ret


; void WaitTimer(byte t);
WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        xor a
        ld (TimerCount),a
    pop de | pop af
ret
