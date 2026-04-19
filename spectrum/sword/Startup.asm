ext InitVram
ext InitSound, SoundHandler
ext Main_
ext KempstonAvailable_

dseg
TimerCount: public TimerCount
    defb 0 

cseg
    out (0feh),a
    call InitSound

    di
        ld hl,0f000h
        ld a,h
        ld i,a
        ld b,0
        do
            ld (hl),0f1h | inc hl
        dwnz
        ld (hl),0f1h

        ld de,Handler
        ld hl,0f1f1h
        ld (hl),0c3h | inc hl
        ld (hl),e | inc hl
        ld (hl),d | inc hl

        im 2

        xor a | ld (TimerCount),a
    ei
    call InitVram        
jp Main_


Handler: public Handler
    di
        push af | push hl | push de | push bc
            exx | ex af,af'
                push af | push hl | push de | push bc
                    push ix | push iy
            
                    ld hl,TimerCount
                    inc (hl)
                    call SoundHandler

                    pop iy | pop ix
                pop bc | pop de | pop hl | pop af
            exx | ex af,af'        
        pop bc | pop de | pop hl | pop af
    ei
reti


WaitTimer_: public WaitTimer_
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
