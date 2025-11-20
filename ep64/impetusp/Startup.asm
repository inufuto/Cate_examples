include "Vram.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
den:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
    defb "EXOS_ROM"
    defw 0

    ld a,0fdh | out (0b1h),a ; Ram page 1
    ld a,1fh | out (080h),a ; Fixbias 
    xor a | out (081h),a ; Border Color

    call InitVram
    call InitSound
    di
        xor a | ld (den),a
        ld a,20h | out (0a7h),a
        ld a,03h | out (0b4h),a
        ld a,0c3h | ld (38h),a
        ld hl,Handler | ld (38h+1),hl
    ei

    ; ld a,low 283 | out (0a0h),a
    ; ld a,high 283 | out (0a1h),a
    ; ; ld a,3fh | out (0a8h),a

    ; ld a,03h | out (0a6h),a
    ; ld a,3fh | out (0abh),a | out (0afh),a
jp Main_

Handler: public Handler
    push af | 
        ld a,(den)
        sub 6
        do | while m
            ld (den),a
            push hl
                ld hl,TimerCount
                inc (hl)
                call SoundHandler
            pop hl
            ld a,(den)
            add a,5
        wend
        ld (den),a
        ld a,03h | out (0b4h),a
    pop af
    ei
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
