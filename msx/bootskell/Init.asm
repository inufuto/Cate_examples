include 'BIOS.inc'

ext InitVram_, InitSound_, TempoValue
ext SoundHandler

    dseg
InterruptRate: defb 0
InterruptValue: defb 0
TimerCount: defb 0 public TimerCount
Hook: defs 5
; Backup_CLIKSW: defs 1

    cseg
Init_:
    public Init_
    push af
        ; ld a,(CLIKSW)
        ; ld (Backup_CLIKSW),a
        xor a
        ld (CLIKSW),a

        call INIGRP
        xor a
        ld (BDRCLR),a
        call CHGCLR
    pop af

    call InitVram_
    call InitSound_

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
ret

; Fin_:
;     public Fin_
;     ld a,(Backup_CLIKSW)
;     ld (CLIKSW),a

;     di
;     ld hl,Hook
;     ld de,H.TIMI
;     ld bc,5
;     ldir
;     ei
; ret	


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
