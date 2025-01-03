include "FixedCode.inc"

ext FixedCode, InitVram
ext InitSound, SoundHandler
ext InitKey
ext Main_

dseg
IntSave:
    defw 0
IntCount:
    defb 0
TimerCount:
    defb 0 
    
cseg
    in a,(29h)
    or 80h
    out (29h),a

    ld hl,FixedCode
    ld de,FixedCode_start
    ld bc,FixedCode_size
    ldir

    call InitSound
    call InitKey
    di
        ld hl,(0f02ah)
        ld (IntSave),hl
        ld hl,Handler
        ld (0f02ah),hl

        xor a
        ld (IntCount),a
        ld (TimerCount),a

        in a,(2dh)
        and 0dfh
        out (2dh),a
    ei
    call InitVram
    call Main_
    di
        ld hl,(IntSave)
        ld (0f02ah),hl
    ei
ret


cseg
Handler: public Handler
    ld a,(IntCount)
    inc a
    cp 16
    if nc
        push hl
            ld hl,TimerCount
            inc (hl)
        pop hl
        call SoundHandler
        xor a
    endif
    ld (IntCount),a

    ld a,5
ret


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
