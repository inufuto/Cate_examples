include "Port.inc"

ext InitKeys
ext InitSound, SoundHandler
ext Main_

dseg
PrevSync: 
    defb 0
TimerCount: public TimerCount
    defb 0


cseg
Startup: 
    ld sp,Startup
    ld a,0c9h | ld (66h),a

    ld hl,ModeBytes
    ld a,(hl) | inc hl
    out (Ppi2Control),a
    ld a,(hl) | inc hl
    out (Ppi2Control),a
    ld bc,16*256
    do
        ld a,c | out (Crtc),a
        ld a,(hl) | inc hl
        out (Crtc+1),a
        inc c
    dwnz

    call InitKeys
    call InitSound
jp Main_

ModeBytes:
    defb 0eh,0dh
    defb 127,80,98,38h
    defb 31,6,25,28
    defb 0,7,20h,0
    defb 0,0,0,0

; void PollVSync();
cseg
PollVSync_: public PollVSync_
    push af
        in a,(Ppi2A)
        and 80h
        if z
            ld a,(PrevSync)
            or a
            if nz
                push bc
                    ld b,50
                    do
                    dwnz
                pop bc
                in a,(Ppi2A)
                and 80h
                if z
                    call Handler
                    xor a
                endif
            endif
        endif
        ld (PrevSync),a
    pop af
ret

Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
    pop hl
    call SoundHandler
ret

; void WaitTimer(byte t);
WaitTimer_: public WaitTimer_
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
