include "kh1000.inc"

ext InitVdp, InitVram
ext InitSound, SoundHandler
ext InitSprites
ext Main_

dseg
TimerCount: defb 0 public TimerCount

cseg
    ld sp,0a800h
    call InitVdp
    call InitVram
    call InitSprites

    ld a,7 | out (PsgAddressPort),a
    ld a,PsgR7Bits | out (PsgWritePort),a
    call InitSound
    ei
jp Main_
    defs 29
rst38h: public rst38h
Handler: public Handler
    push af
        ld a,(VdpAddress+2)
        and 80h
        if nz
            push hl | push de | push bc
                ; call UpdateSprites

                ld a,(TimerCount)
                or a
                if nz
                    dec a
                    ld (TimerCount),a
                endif
    
                call SoundHandler
            pop bc | pop de | pop hl
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
