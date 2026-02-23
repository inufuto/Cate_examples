include 'Vram.inc'

extrn InitVram_, InitSound_
extrn SoundHandler

CRTC equ 1800h

dseg
PrevSync: defb 0
TimerCount: defb 0 public TimerCount

cseg
CValues:
    defb 111,80,89,56
Init_: public  Init_
    push af | push bc
        ld de,400h
        ld hl,CValues
        ld bc,CRTC
        do
            out (c),e | inc bc
            ld a,(hl) | inc hl
            out (c),a | dec bc
            inc e
            dec d
        while nz | wend
        ld bc,1a02h
        in a,(c)
        and not 40h
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

        call InitVram_
        call InitSound_
    pop bc | pop af
ret

Fin_:
    public Fin_
ret


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


ext SoundHandler
Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
jp SoundHandler


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
