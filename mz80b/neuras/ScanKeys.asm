include "mz80b.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit_Left equ 0
Keys_Bit_Right equ 1
Keys_Bit_Up equ 2
Keys_Bit_Down equ 3
Keys_Bit_Button0 equ 4
Keys_Bit_Button1 equ 5


cseg
ScanKeys_:
    public ScanKeys_
    push bc
        ld c,0

        in a,(PortPIO_A)
        and 0e0h
        or 1 or 10h
        out (PortPIO_A),a
        in a,(PortPIO_B)
        bit 2,a     ;8
        if z
            set Keys_Bit_Up,c
        endif

        in a,(PortPIO_A)
        and 0e0h
        or 2 or 10h
        out (PortPIO_A),a
        in a,(PortPIO_B)
        bit 2,a ;2
        if z
            set Keys_Bit_Down,c
        endif
        bit 4,a ;4
        if z
            set Keys_Bit_Left,c
        endif
        bit 6,a ;6
        if z
            set Keys_Bit_Right,c
        endif

        in a,(PortPIO_A)
        and 0e0h
        or 3 or 10h
        out (PortPIO_A),a
        in a,(PortPIO_B)

        bit 0,a ;tab
        if z
            set Keys_Bit_Button1,c
        endif
        bit 1,a ;space
        if z
            set Keys_Bit_Button0,c
        endif
        bit 3,a ;up
        if z
            set Keys_Bit_Up,c
        endif
        bit 4,a ;down
        if z
            set Keys_Bit_Down,c
        endif
        bit 5,a ;left
        if z
            set Keys_Bit_Left,c
        endif
        bit 6,a ;right
        if z
            set Keys_Bit_Right,c
        endif

        ld a,c
    pop bc
ret
