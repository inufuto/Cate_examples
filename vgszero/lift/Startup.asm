include "vgszero.inc"

ext InitVram, HScroll_
ext InitSound,SoundHandler
ext UpdateSprites_
ext Main_

dseg
PrevSync:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
    call InitVram
    call InitSound
jp Main_


PollVSync_: public PollVSync_
    push af
        ld a,(VdpStatus)
        and 80h
        if nz
            push af
                ld a,(PrevSync)
                or a
                call z,Handler
            pop af
        endif
        ld (PrevSync),a
    pop af
ret


Handler: public Handler
    push af | push hl
        ld hl,TimerCount
        inc (hl)
        ld a,(HScroll_)
        ld (BgScrollX),a
    pop hl | pop af
    call UpdateSprites_
    call SoundHandler
ret


WaitTimer_:
    public WaitTimer_
    push af | push de
        ld e,a
        do
            call PollVSync_
            ld a,(TimerCount)
            cp e
        while c | wend
        xor a
        ld (TimerCount),a
    pop de | pop af
ret
