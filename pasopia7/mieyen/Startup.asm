include "FixedCode.inc"

ext FixedCode, InitVram
ext InitSound, SoundHandler
ext Main_

BIOS    equ 5

dseg
oldKeyInt:
    defw 0
TimerCount:
    defb 0 public TimerCount
    
cseg
    ld bc,2*256 + 36
    call BIOS
    ld bc,40*256 + 35
    call BIOS
    ld bc,0fh*256 + 37
    call BIOS

    ld hl,FixedCode
    ld de,FixedCode_start
    ld bc,FixedCode_size
    ldir

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

    ld a,08h | out (0dh),a

    call InitVram

    call Main_
    di
        ld hl,(oldKeyInt)
        ld (0fefah),hl

        ld hl,(Handler_end+1)
        ld (0fef6h),hl
    ei
ret


KeyInt:
    ei
    reti


    cseg
Handler: public Handler
    push af | push hl
        ld hl,TimerCount
        inc (hl)
        call SoundHandler
    pop hl | pop af
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