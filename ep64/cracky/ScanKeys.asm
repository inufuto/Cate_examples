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


; byte ScanKeys();
ScanKeys_: public ScanKeys_
    push de
        ld e,0

        xor a | out (0b5h),a
        in a,(0b5h)
        bit 5,a ; X
        if z
            set Keys_Bit_Button1,e
        endif
        bit 6,a ; Z
        if z
            set Keys_Bit_Button0,e
        endif

        ld a,6 | out (0b5h),a
        in a,(0b5h)
        bit 4,a ; L
        if z
            set Keys_Bit_Up,e
        endif

        ld a,7 | out (0b5h),a
        in a,(0b5h)
        bit 1,a ; Down
        if z
            set Keys_Bit_Down,e
        endif
        bit 2,a ; Right
        if z
            set Keys_Bit_Right,e
        endif
        bit 3,a ; Up
        if z
            set Keys_Bit_Up,e
        endif
        bit 5,a ; Left
        if z
            set Keys_Bit_Left,e
        endif
        bit 6,a ; ENTER
        if z
            set Keys_Bit_Button1,e
        endif

        ld a,8 | out (0b5h),a
        in a,(0b5h)
        bit 2,a ; ,
        if z
            set Keys_Bit_Left,e
        endif
        bit 3,a ; /
        if z
            set Keys_Bit_Right,e
        endif
        bit 4,a ; .
        if z
            set Keys_Bit_Down,e
        endif
        bit 6,a ; Space
        if z
            set Keys_Bit_Button0,e
        endif

        ld a,e
    pop de
ret
