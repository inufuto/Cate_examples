include "Vdp.inc"

ext EnableNmi, DisableNmi, InitVdp, NmiEnabled
ext InitVram, InitSound, SoundHandler
ext InitSprites, UpdateSprites
ext Main_

dseg
TimerCount: defb 0 public TimerCount


cseg
    defb 55h,0aah
    defw 0
    defw 0
    defw 0
    defw 0
    defw Startup
    ret ; rst 08h
    defb 0,0
    ; rst 10h
    inc hl
    dec hl
    ret
    ret ; rst 18h
    defb 0,0
    ret ; rst 20h
    defb 0,0
    ret ; rst 28h
    defb 0,0
    ret ; rst 30h
    defb 0,0
    reti
    defb 0
jp Handler


Startup: public Startup
    call DisableNmi
    call InitVdp
    call InitSound
    call InitVram
    call InitSprites
    call EnableNmi
jp Main_


Handler: public Handler
    push af
        ld a,(NmiEnabled)
        or a
        if nz
            in a,(VdpPort+1)
            and 80h
            if nz
                push af | push hl | push de | push bc
                    call UpdateSprites

                    ld hl,TimerCount
                    inc (hl)
                pop bc | pop de | pop hl | pop af
                call SoundHandler
            endif
        endif
    pop af
; ei
retn


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        call DisableNmi
            xor a
            ld (TimerCount),a
        call EnableNmi
    pop de | pop af
ret
