ext InitSound, SoundHandler
ext Main_

SoundPortFlag equ 0fe09h
CtcPort equ 28h

dseg
TimerDiv:
    defb 0 
TimerCount:
    defb 0 

cseg
    ld a,40h
    call 1022h
    ld a,80
    call 0fbeh

    call InitSound
    di
        ld a,0a7h | out (CtcPort+3),a
        ld a,130 | out (CtcPort+3),a ; 120Hz

        ld hl,KeyInt
        ld (0fefah),hl

        ld hl,(0fef6h)
        ld (Handler_end+1),hl
        ld hl,Handler
        ld (0fef6h),hl

        xor a
        ld (TimerCount),a
        ld (TimerDiv),a

        ; ld a,9bh | out (1bh),a
    ei
jp Main_

KeyInt:
    ei
reti


cseg
Handler: public Handler
    push af | push hl
        ld a,(TimerDiv)
        xor 1
        ld (TimerDiv),a
        if z
            call SoundHandler
            ld hl,TimerCount
            inc (hl)
        endif
    pop hl | pop af
;     ei
; reti
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
