include "Vdp.inc"
include "Vram.inc"

ext InitVdp
ext InitVram
ext InitSound, SoundHandler, Sound_Bonus_
ext InitSprites
ext Main_


dseg
Port3eh: public Port3eh
    defb 0
TimerCount: public TimerCount
    defb 0


cseg
    di
        ld sp,0e000h
        im 1

        call Wait
        call InitVdp
        call Wait
        call InitSound
        call InitVram
        call InitSprites
    ei
    ld a,92h
    out (0dfh),a

    ; call Wait
    call Sound_Bonus_
jp Main_

    defs 30h-23h+3
_rst30: public _rst30
    push hl
    pop hl
    push hl
    pop hl
    ret

    defs 38h-30h-5
_rst38: public _rst38
    jp Handler

Wait:
    ld de,0
    do
        dec de
        ld a,e
        or d
    while nz | wend
ret


Handler: public Handler
    push af
        in a,(VdpPort+1)
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
    pop af
    ei
reti


WaitTimer_: public WaitTimer_
    push af
        ld (TimerCount),a
        do
            ld a,(TimerCount)
            or a
        while nz | wend
    pop af
ret
