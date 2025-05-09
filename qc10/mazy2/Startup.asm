ext InitSound, SoundHandler, Sound_Hit_
ext InitVram
ext InitKey
ext Main_

MemBankPort equ 18h
Interval equ 1996800/60

dseg
TimerCount:
    defb 0
cseg
    ld a,12h | out (MemBankPort),a
    call InitSound
    call InitKey
    di
        ld a,2dh | out (09h),a
        
        ld a,0b4h | out (03h),a
        ld a,low Interval | out (02h),a
        ld a,high Interval | out (02h),a
    ei
                            ld a,34h | out (14h),a

    call InitVram
    call Sound_Hit_
jp Main_

HandleNone: public HandleNone
ei | reti

TimerHandler: public TimerHandler
    push af | push hl
        ld hl,TimerCount
        inc (hl)
        call SoundHandler
        
        ld a,64h | out (08h),a
    pop hl | pop af
ei | reti


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
