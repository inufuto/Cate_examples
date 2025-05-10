include "Vram.inc"
include "Vdp.inc"

ext InitVdp
ext InitVram, InitSound
ext SoundHandler
ext InitSprites
ext InitKeys_
ext Main_

dseg
TimerCount:  public TimerCount 
    defb 0

cseg
    ld sp,0c800h

    ld de,0
    do
        dec de
        ld a,e
        or d
    while nz | wend

    im 1
    call InitVdp
    call InitVram
    call InitSound
    call InitKeys_
    call InitSprites
    ei
jp Main_

    defs 16
_rst30: public _rst30
    nop
    ret

    defs 6
_rst38: public _rst38
    jp Handler

Handler: public Handler
    push af
        in a,(VdpPort+1)
        and 80h
        if nz
            push hl
                ld hl,TimerCount
                inc (hl)
            pop hl
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
