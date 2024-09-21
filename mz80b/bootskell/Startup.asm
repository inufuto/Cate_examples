include "mz80b.inc"

ext InitVram_, InitSound_, Main_

Interval equ 31250/60

Text equ 0d000h

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

    ld a,2
    out (GraphPage),a

    ld hl,Text
    ld bc,1000
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
    call InitVram_
    call InitSound_
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
    defb PortPIO_ModeB,0cfh
    defb PortPIO_ModeB,0ffh
    defb PortPIO_ModeB,07h
    defb GraphPage,02h
    defb 0


Wait_ : public Wait_
    push af | push bc
        ld bc, 2000
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc | pop af
ret
