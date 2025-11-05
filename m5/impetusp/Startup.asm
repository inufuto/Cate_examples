include "Vdp.inc"
include "Vram.inc"

ext InitVdp
ext InitVram, InitSound, TempoValue
ext SoundHandler
ext InitSprites, UpdateSprites
ext Main_

Hook equ 7006h

    dseg
TimerCount: defb 0 public TimerCount

cseg
    defb 0
    defw Startup
    defw 002eh
Startup: public Startup
    call InitVdp
    call InitVram
    call InitSprites
    call InitSound
    di
        ld hl,7000h
        ld b,64
        do
            ld (hl),6ch | inc hl
            ld (hl),18h | inc hl
        dwnz
        ld hl,Handler
        ld (7006h),hl
    ei
jp Main_


Handler: public Handler
    push af | push hl | push de | push bc
        call UpdateSprites

        in a,(VdpPort+1)
        and 80h
        if nz
            push hl
                ld hl,TimerCount
                inc (hl)
            pop hl
            call SoundHandler
        endif
    pop bc | pop de | pop hl | pop af
    ei
reti


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
