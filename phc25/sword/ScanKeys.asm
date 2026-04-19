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

        ld a,7 | out (0c1h),a
        in a,(0c1h) | ld b,a
        ld a,80h | out (0c0h),a

        ld a,15 | out (0c1h),a
        ld a,0c0h | out (0c0h),a

        ld a,14 | out (0c1h),a
        in a,(0c1h) | ld c,a
        
        ld a,7 | out (0c1h),a
        ld a,b | out (0c0h),a

        ld a,c
        ld c,0
        bit 0,a ; Up
        if z
            set Keys_Bit_Up,c
        endif
        bit 1,a ; Down
        if z
            set Keys_Bit_Down,c
        endif
        bit 2,a ; Left
        if z
            set Keys_Bit_Left,c
        endif
        bit 3,a ; Right
        if z
            set Keys_Bit_Right,c
        endif
        bit 4,a ; Button0
        if z
            set Keys_Bit_Button0,c
        endif
        bit 5,a ; Button1
        if z
            set Keys_Bit_Button1,c
        endif
        
        in a,(80h)
        bit 4,a ; Up
        if z
            set Keys_Bit_Up,c
        endif

        in a,(81h)
        bit 4,a ; Down
        if z
            set Keys_Bit_Down,c
        endif

        in a,(82h)
        bit 4,a ; Left
        if z
            set Keys_Bit_Left,c
        endif

        in a,(83h)
        bit 4,a ; Right
        if z
            set Keys_Bit_Right,c
        endif
        bit 7,a ; Space
        if z
            set Keys_Bit_Button0,c
        endif

        in a,(86h)
        bit 2,a ; J
        if z
            set Keys_Bit_Left,c
        endif
        bit 3,a ; J
        if z
            set Keys_Bit_Down,c
        endif

        in a,(87h)
        bit 1,a ; I
        if z
            set Keys_Bit_Up,c
        endif
        bit 2,a ; K
        if z
            set Keys_Bit_Right,c
        endif

        in a,(88h)
        bit 2,a ; Shift
        if z
            set Keys_Bit_Button1,c
        endif

        ld a,c
    pop bc
ret 
