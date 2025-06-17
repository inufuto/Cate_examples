include "BIOS.inc"

ext InitVram
ext InitSound, SoundHandler
ext Main_

dseg
DsegTop:
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

cseg
Startup:
    ld sp,Startup

    xor a
    ld (CLIKSW),a

    call InitVram
    call InitSound

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
        ld hl,Handler
        ld (H.TIMI+1),hl
    ei
jp Main_


Handler: public Handler
    push af | push hl
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
    pop hl | pop af
Handler_end:
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
