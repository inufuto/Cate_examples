include "Vram.inc"

ext InitSound, SoundHandler
ext InitVram 
ext Main_

CRTC equ 1800h

dseg
PrevSync: defb 0
TimerCount: defb 0 public TimerCount

cseg
    ld bc,CRTC
    ld a,1
    out (c),a
    inc bc
    ld a,VramWidth
    out (c),a

    ld a,0aah
    ld bc,1000h
    out (c),a
    ld a,0cch
    inc b
    out (c),a
    ld a,0f0h
    inc b
    out (c),a
    ld a,0feh
    inc b
    out (c),a

    xor a
    ld (PrevSync),a
    ld (TimerCount),a

    call InitSound
    call InitVram
jp Main_

PollVSync_: public PollVSync_
    push af | push bc
        ld bc,1a01h
        in a,(c)
        and 80h
        if nz
            ld a,(PrevSync)
            or a
            call z,Handler
            ld a,80h
        endif
        ld (PrevSync),a
    pop bc | pop af
ret


Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
jp SoundHandler
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
        ; di
            xor a
            ld (TimerCount),a
        ; ei
    pop de | pop af
ret
