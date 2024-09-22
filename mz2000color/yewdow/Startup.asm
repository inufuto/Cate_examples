include "mz2000.inc"

ext Main_
ext InitVram, InitSound

Interval equ 31250/60
Text equ 0d000h

dseg
LastTimer:
    defb 0
TimerCount: public TimerCount
    defb 0

cseg
    ld hl,0c000h
    ld sp,hl

    ld hl,PortTable
    do
        ld a,(hl)
        or a
    while nz
        inc hl
        ld c,a
        ld a,(hl) | inc hl
        out (c),a
    wend

    ld a,0c0h
    out (PortPIO_A),a
    ld hl,Text
    ld bc,2000
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
    ld a,080h
    out (PortPIO_A),a


    call InitVram
    call InitSound
jp Main_

PortTable:
    defb Port8255_Mode,02h
    defb Port8253_Mode,34h ;Ch0 00 11 010 0
    defb Port8253_Mode,54h ;Ch1 01 01 010 0
    defb Port8253_Mode,094h ;Ch2 10 01 010 0
    defb Port8253_Ch2,00h
    defb Port8253_Ch1,00h
    defb Port8253_Ch0,low Interval
    defb Port8253_Ch0,high Interval
    defb PortPIO_ModeA,0cfh
    defb PortPIO_ModeA,00h
    defb PortPIO_A,80h
    defb TextColor,00h
    defb DisplayPlane,0fh
    defb BackgroundColor,00h
    defb PortPIO_ModeB,0cfh
    defb PortPIO_ModeB,0ffh
    defb PortPIO_ModeB,07h
    defb 0

PollTimer_: public PollTimer_
    push af | push hl
        in a,(Port8253_Ch1) | ld l,a
        ld a,(LastTimer)
        cp l
        if nz
            ld a,l
            ld (LastTimer),a
            call Handler
        endif
    pop hl | pop af
ret

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
            call PollTimer_
            ld a,(TimerCount)
            cp e
        while c | wend
        ; di
            xor a
            ld (TimerCount),a
        ; ei
    pop de | pop af
ret
