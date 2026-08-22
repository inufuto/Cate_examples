ext InitSound
ext Main_

PortAddress equ 6800h
PortByte equ 08h

dseg
TimerCount: public TimerCount
    defb 0

cseg
    ld a,PortByte
    ld (PortAddress),a

    xor a
    ld (TimerCount),a
    call InitSound

    di
        ld a,0c3h | ld (787dh),a
        ld hl,Handler | ld (787dh+1),hl
    ei

jp Main_


Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
ret


WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do
            ld a,(TimerCount)
            cp e
        while c | wend
        xor a
        ld (TimerCount),a
    pop de | pop af
ret
