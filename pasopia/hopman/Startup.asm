SoundPortFlag equ 0fe09h

ext InitSound, SoundHandler
ext Main_

dseg
oldKeyInt:
    defw 0
TimerCount:
    defb 0 

cseg
    ld a,40h
    call 1022h
    ld a,80
    call 0fbeh

    call InitSound

    di
        ld hl,(0fefah)
        ld (oldKeyInt),hl
        ld hl,KeyInt
        ld (0fefah),hl

        ld hl,(0fef6h)
        ld (Handler_end+1),hl
        ld hl,Handler
        ld (0fef6h),hl

        xor a
        ld (TimerCount),a
    ei
jp Main_

KeyInt:
    ret


cseg
Handler: public Handler
    push af | push hl
        ld hl,TimerCount
        inc (hl)
        call SoundHandler
    pop hl | pop af
    ; ei
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
