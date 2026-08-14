ext InitVram_
ext InitSound, SoundHandler
ext Main_

dseg
TimerCount: defb 0
SoundDiv: defb 0
OldHandler: defs 3

cseg
    ld a,(0fa27h)
    and 0f9h
    out (0b0h),a
    ld hl,0c000h
    ld bc,512
    do
        ld (hl),8ch | inc hl
        dec bc
        ld a,c 
        or b
    while nz | wend
    
    xor a
    ld (0fa2dh),a ; click
    ld (TimerCount),a
    ld (SoundDiv),a

    call InitSound

    di
        ld a,0c3h
        ld (OldHandler),a
        ld hl,(0FA06h) ; interrupt handler
        ld (OldHandler+1),hl
        ld hl,Handler
        ld (0FA06h),hl
    ei
    call Main_
    di
        ld hl,(Handler_end+1)
        ld (0FA06h),hl ; interrupt handler
    ei
ret	


Handler: public Handler
    push af | push hl
        ld a,(SoundDiv)
        dec a
        ld (SoundDiv),a
        if z
            ld a,10
            ld (SoundDiv),a
            call SoundHandler
            ld hl,TimerCount
            inc (hl)
        endif
    pop hl | pop af
Handler_end:
jp OldHandler

WaitTimer_:
    public WaitTimer_
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
