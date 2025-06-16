include "BIOS.inc"

ext InitVram, DspPage
ext InitSprites
ext InitSound, SoundHandler
ext Main_

dseg
InterruptRate:
    defb 0
InterruptValue:
    defb 0
TimerCount: public TimerCount
    defb 0
Hook: 
    defs 5
TempoValue: public TempoValue
    defw 600
VScroll_: public VScroll_
    defb 0

cseg
    xor a
    ld (CLIKSW),a

    call InitVram
    call InitSound
    call InitSprites

    ld a,(IDBYTE)
    and 80h
    if z
        ld a,5
        ld hl,600/2
    else
        ld a,6
        ld hl,500/2
    endif
    ld (InterruptRate),a
    ld (TempoValue),hl
    xor a
    ld (InterruptValue),a
    di
        ld hl,H.TIMI
        ld de,Hook
        ld bc,5
        ldir
        ld a,0c3h   ;jp
        ld (H.TIMI),a
        ld hl,TimerHandler
        ld (H.TIMI+1),hl
        ld (H.KEYI),a
        ld hl,Handler
        ld (H.KEYI+1),hl
    ei
    ld bc,1400h | call WRTVDP
    ld bc,0d13h | call WRTVDP
jp Main_


Handler: public Handler
    push af | push bc
        ld a,(VdpOutPort) | ld c,a
        inc c
        ld a,1 | out (c),a
        ld a,15 or 80h | out (c),a
        push bc
            ld a,(VdpInPort) | ld c,a
            inc c
            in a,(c)
        pop bc
        and 1
        if nz
            ld a,(VScroll_)
            out (c),a
            ld a,23 or 80h | out (c),a ; Display offset

            ld hl,(InterruptRate)
            ld a,h
            sub l
            ld h,a
            do
                bit 7,h
            while nz
                add a,5
                ld h,a
                push hl
                    ld a,(TimerCount)
                    or a
                    if nz
                        dec a
                        ld (TimerCount),a
                    endif
                pop hl
            wend
            ld (InterruptRate),hl
            call SoundHandler
        endif
        xor a | out (c),a
        ld a,15 or 80h | out (c),a
    pop bc | pop af
ret

TimerHandler: public TimerHandler
    push af | push hl | push bc
        ld a,(VdpOutPort) | ld c,a
        inc c
      
        ld a,(DspPage) | out (c),a
        ld a,2 or 80h | out (c),a
      
        xor a | out (c),a
        ld a,23 or 80h | out (c),a ; Display offset


    pop bc | pop hl | pop af
jp Hook


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
