ext InitVram
ext InitSound, SoundHandler
ext Main_

Segment equ 04h

dseg
TimerCount:
    defb 0
VCount:
    defb 0

cseg
jp Startup
defs 64-3
defb "MOS"
defb 0,0

Startup: public Startup
    call InitVram
    call InitSound

    ld hl,InitCmd
    ld bc,InitCmdE-InitCmd
    defb 49h | rst 18h

    ld a,14h
    ld e,32h
    defb 5bh | ld hl,AdlHandler | defb Segment
    defb 49h | rst 08h
    defb 5bh | ld (AdlHandlerE+1),hl | defb Segment
jp Main_
InitCmd:
    defb 23,1,0
    defb 22,8+128
    defb 23,1,0
InitCmdE:

PollTimer_: public PollTimer_
    push af
        do
            ld a,(VCount)
            or a
        while nz
            call nz,Handler
            di
                ld a,(VCount)
                dec a
                ld (VCount),a
            ei
        wend
    pop af
ret

Handler: public Handler
    push hl
        ld hl,TimerCount
        inc (hl)
        call SoundHandler
    pop hl
ret
; defb 5bh | ret

AdlHandler: public AdlHandler
    push af | push hl
        ld hl,VCount | defb Segment
        inc (hl)
    pop hl | pop af
AdlHandlerE:
jp 0 | defb 0

WaitTimer_: public WaitTimer_
    push af | push de
        ld e,a
        do  
            call PollTimer_
            ld a,(TimerCount)
            cp e
        while c | wend
        xor a
        ld (TimerCount),a
    pop de | pop af
ret
