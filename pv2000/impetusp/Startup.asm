include "Vdp.inc"
include "Vram.inc"

ext EnableNmi, DisableNmi, InitVdp, NmiEnabled
ext InitVram, InitSound, TempoValue
ext InitSprites, UpdateSprites
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
    call DisableNmi
        ld hl,Handler
        ld (NmiHook+1),hl
        call InitVram
        call InitSprites
    call EnableNmi
jp Main_


Handler: public Handler
    push af | push hl | push de | push bc
        ld a,(NmiEnabled)
        or a
        if nz
            ld a,(VdpAddress+1)
            and 80h
            if nz
                call UpdateSprites
                ld a,(TimerCount)
                or a
                if nz
                    dec a
                    ld (TimerCount),a
                endif
                call SoundHandler
            endif
        endif
    pop bc | pop de | pop hl | pop af
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
