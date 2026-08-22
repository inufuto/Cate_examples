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


ScanKeys_: public ScanKeys_
    push bc
        ld c,0

        ld a,(687fh)
        bit 1,a ; L
        if z
            set Keys_Bit_Up,c
        endif
        bit 3,a ; K
        if z
            set Keys_Bit_Up,c
        endif

        ld a,(68efh)
        bit 1,a ; .
        if z
            set Keys_Bit_Right,c
        endif
        bit 3,a ; ,
        if z
            set Keys_Bit_Down,c
        endif
        bit 4,a ; SPACE
        if z
            set Keys_Bit_Button0,c
        endif
        bit 5,a ; M
        if z
            set Keys_Bit_Left,c
        endif

        ld a,(68bfh)
        bit 1,a ; O
        if z
            set Keys_Bit_Left,c
        endif
        bit 4,a ; P
        if z
            set Keys_Bit_Right,c
        endif

        ld a,(68fbh)
        bit 1,a ; X
        if z
            set Keys_Bit_Button1,c
        endif
        bit 2,a ; SHIFT
        if z
            set Keys_Bit_Button1,c
        endif
        bit 4,a ; Z
        if z
            set Keys_Bit_Button0,c
        endif

        ld a,(68fdh)
        bit 4,a ; A
        if z
            set Keys_Bit_Down,c
        endif

        ld a,(68feh)
        bit 4,a ; Q
        if z
            set Keys_Bit_Up,c
        endif

        ld a,c
    pop bc
ret
