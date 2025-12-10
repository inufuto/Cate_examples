include "Vram.inc"
include "Vdp.inc"

ext Port3eh
ext InitVdp
ext InitVram
ext InitSprites, UpdateSprites
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: public TimerCount
    defb 0

cseg
    di
    im 1
    ld sp,0dff0h

    xor a
    ld (0fffch),a
    ld (0fffdh),a
    inc a
    ld (0fffeh),a
    inc a
    ld (0ffffh),a

    do
        in a,(7eh)
        cp 0b0h
    while nz | wend

    ld a,0ffh | out (2),a
    ld a,38h | out (5),a
    ld a,0ffh | out (6),a

    do
        in a,(7eh)
        cp 0b0h
    while nz | wend
jr Start2
    defs 1
_Rst30: public _Rst30
    push hl
    pop hl
    push hl
    pop hl
    ret

    defs 38h-35h
_Rst38: public _Rst38
    jp Handler

Start2:
    call InitVdp
    call InitSound
    call InitVram
    call InitSprites
    di
        ld a,1-1 | out (VdpPort+1),a
        ld a,10 or 80h | out (VdpPort+1),a

        ld a,6*8 | out (VdpPort+1),a
        ld a,8 or 80h | out (VdpPort+1),a
        ld a,224-8*3 | out (VdpPort+1),a
        ld a,9 or 80h | out (VdpPort+1),a
    ei
jp Main_


; ext UpdateSprites
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
        ; else
        ;     in a,(7eh)
        ;     cp  192-2
        ;     if nc
        ;         ld a,(roll)
        ;         or a
        ;         if nz
        ;             xor a | ld (roll),a
        ;             ld a,6*8 | out (VdpPort+1),a
        ;             ld a,8 or 80h | out (VdpPort+1),a
        ;             ld a,224-8*3 | out (VdpPort+1),a
        ;             ld a,9 or 80h | out (VdpPort+1),a
        ;             ; call UpdateSprites
        ;         endif
        ;     else
        ;         cp 5*8-1
        ;         if nc
        ;             ld a,(roll)
        ;             or a
        ;             if z
        ;                 inc a | ld (roll),a
        ;                 ld a,(HScroll_) | neg | out (VdpPort+1),a
        ;                 ld a,8 or 80h | out (VdpPort+1),a
        ;                 ld a,(VScroll_)
        ;                 cp 192
        ;                 if nc
        ;                     add a,224
        ;                 endif
        ;                 out (VdpPort+1),a
        ;                 ld a,9 or 80h | out (VdpPort+1),a
        ;             endif
        ;         endif
        ;     endif
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
