include "FixedCode.inc"

ext FixedCode
ext InitVram
ext InitSprites
ext InitSound, SoundHandler
ext Main_

dseg
PrevSync:
    defb 0
den:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
    ld hl,FixedCode
    ld de,FixedCode_start
    ld bc,FixedCode_size
    ldir

    ld a,0 ; Video mode
    call 0bc0eh

    call InitSound
    di
        ld bc,0bc00h
        ld hl,Sequence
        ld e,17
        do
            ld a,(hl) | inc hl
            out (c),a
            dec e
        while nz | wend

        call InitPlus

        xor a | ld (den),a
        ld a,0c3h
        ld (38h),a
        ld hl,Handler
        ld (38h+1),hl
    ei
    call InitVram
    call InitSprites
jp Main_

Sequence:
    defb 255,0,255,119,179,81,168,212,98,57,156,70,43,21,138,205,238

Handler: public Handler
    push af
        push bc
            ld bc,0f500h
            in a,(c)
        pop bc
        and 1
        if z
            ld a,(PrevSync)
            or a
            if nz
                ld a,(den)
                sub 6
                do | while m
                    push hl
                        ld hl,TimerCount
                        inc (hl)
                    pop hl
                    add a,5
                wend
                ld (den),a
                call SoundHandler
            endif
            xor a
        endif
        ld (PrevSync),a
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
