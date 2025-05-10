include "Vdp.inc"
include "Vram.inc"

ext EnableNmi, DisableNmi, InitVdp, NmiEnabled
ext InitVram, InitSound, TempoValue
ext InitSprites
ext SoundHandler
ext Main_

NmiHook equ 7498h

dseg
TimerCount: defb 0 public TimerCount


cseg
    jp startup
startup:
    call InitVdp
    call InitSound
    call EnableNmi
    ; di
        ld hl,Handler
        ld (NmiHook+1),hl
    ; ei
    call InitVram
    call InitSprites
jp Main_


Handler: public Handler
    push af
        ld a,(NmiEnabled)
        or a
        if nz
            ld a,(VdpAddress+1)
            and 80h
            if nz
                ld a,(TimerCount)
                or a
                if nz
                    dec a
                    ld (TimerCount),a
                endif
                call SoundHandler
            endif
        endif
    pop af
; ei
retn


WaitTimer_:
    public WaitTimer_
    push af
        ld (TimerCount),a
        do
            ld a,(TimerCount)
            or a
        while nz | wend
    pop af
ret
