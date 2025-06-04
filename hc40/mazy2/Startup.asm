include "hc40.inc"

ext InitKeys,ExitKeys
ext InitSound
ext Main_

dseg
jumpVECOVF:
    defb 1
    defw 0
TimerCount: public TimerCount
    defb 0


cseg
    di
        ld a,0c3h | ld (jumpVECOVF),a
        ld hl,(VECOVF) | ld (jumpVECOVF+1),hl
        ld hl,TimerHandler | ld (VECOVF),hl
    ei
    call InitSound
    call InitKeys
    call Main_
    call ExitKeys
    di
        ld hl,(jumpVECOVF+1) | ld (VECOVF),hl
    ei
ret


TimerHandler: public TimerHandler
    push af
        ld a,(TimerCount)
        add a,6
        ld (TimerCount),a
    pop af
jp jumpVECOVF
;     ei
; reti



WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            sub e
        while c | wend
        di
            xor a
            ld (TimerCount),a
        ei
    pop de | pop af
ret
