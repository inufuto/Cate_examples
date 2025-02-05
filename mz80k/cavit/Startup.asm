interrupt_interval equ 20

ext InitSound, SoundHandler
ext Main_

dseg
TimerCount:
    defb 0 
PrevBlank:
    defb 0

cseg
    call InitSound
    di
        ld hl,(1038h+1) ; interrupt handler
        ld (Handler_end+1),hl
        ld hl,Handler
        ld (1038h+1),hl

        ld hl,0e007h
        ld (hl),0b0h
        ld (hl),074h
        dec l
        ld (hl),1+1
        ld (hl),0
        dec l
        ld (hl),interrupt_interval
        ld (hl),0
        ld a,5
        ld (0e003h),a

        xor a
        ld (TimerCount),a
    ei
jp Main_


Handler: public Handler
    push af | push hl
        ld hl,0e002h
        ld a,(hl)
        and 80h
        if z
            ld hl,PrevBlank
            cp (hl)
            if nz
                ld (hl),a
        
                ld hl,TimerCount
                inc (hl)
                call SoundHandler
            endif
        else
            ld (PrevBlank),a
        endif

        ld a,1+1
        ld (0e006h),a
        xor a
        ld (0e006h),a
    pop hl | pop af
    ei
    ret
Handler_end:
    jp 0


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
