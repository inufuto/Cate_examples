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
ScanKeys_: public ScanKeys_
    push bc
        ld c,0

        ld a,(3810h)
        bit 0,a ; 0
        if nz
            set Keys_Bit_Button0,c
        endif
        bit 2,a ; 2
        if nz
            set Keys_Bit_Down,c
        endif
        bit 4,a ; 4
        if nz
            set Keys_Bit_Left,c
        endif
        bit 6,a ; 6
        if nz
            set Keys_Bit_Right,c
        endif

        ld a,(3820h)
        bit 0,a ; 8
        if nz
            set Keys_Bit_Up,c
        endif

        ld a,(3840h)
        bit 0,a ; Enter
        if nz
            set Keys_Bit_Button1,c
        endif
        bit 3,a ; Up
        if nz
            set Keys_Bit_Up,c
        endif
        bit 4,a ; Down
        if nz
            set Keys_Bit_Down,c
        endif
        bit 5,a ; Left
        if nz
            set Keys_Bit_Left,c
        endif
        bit 6,a ; Right
        if nz
            set Keys_Bit_Right,c
        endif
        bit 7,a ; Space
        if nz
            set Keys_Bit_Button0,c
        endif

        ld a,c
    pop bc
ret
