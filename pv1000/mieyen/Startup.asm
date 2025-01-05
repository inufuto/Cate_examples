ext InitSound, SoundHandler, InitKey_, UpdateScan_
ext Main_

dseg
divide: defb 0
TimerCount: defb 0 public TimerCount

    cseg
Startup: public  Startup
    call InitKey_
    call InitSound
    xor a
    ld (divide),a
    ld (TimerCount),a
    ; ld a,3
    ; out (0fch),a
    ei
jp Main_

Handler: public Handler
    push af
        in a,(0fch)
        and 1
        if z
            ld a,(divide)
            inc a
            ld (divide),a
            and 0fh
            if z
                push hl
                    ld hl,TimerCount
                    inc (hl)
                pop hl
                call SoundHandler
            endif
        endif
        call UpdateScan_
    pop af
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
