include "Vdp.inc"
include "Vram.inc"

ext InitVdp
ext InitVram
ext InitSound, SoundHandler, Sound_Up_
ext InitSprites, UpdateSprites
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
    call Sound_Up_
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
            push af | push hl | push de | push bc
            exx | push af | push hl | push de | push bc | exx
                call UpdateSprites

                ld hl,TimerCount
                inc (hl)
            exx | pop bc | pop de | pop hl | pop af | exx
            pop bc | pop de | pop hl | pop af
            call SoundHandler
        endif
    pop af
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
