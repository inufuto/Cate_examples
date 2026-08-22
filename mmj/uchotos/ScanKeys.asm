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
    push de
        ld e,0

        ld a,0feh | ld (7002h),a
        ld a,(7001h)
        bit 0,a ; 1
        if z
            set Keys_Bit_Button0,e
        endif
        bit 1,a ; 2
        if z
            set Keys_Bit_Button1,e
        endif
        bit 2,a ; 3
        if z
            set Keys_Bit_Button0,e
        endif

        ld a,0fdh | ld (7002h),a
        ld a,(7001h)
        bit 4,a ; 11
        if z
            set Keys_Bit_Left,e
        endif
        bit 5,a ; 12
        if z
            set Keys_Bit_Down,e
        endif
        bit 6,a ; 13
        if z
            set Keys_Bit_Right,e
        endif
        bit 7,a ; tsumo
        if z
            set Keys_Bit_Button0,e
        endif

        ld a,0fbh | ld (7002h),a
        ld a,(7001h)
        bit 0,a ; ron
        if z
            set Keys_Bit_Right,e
        endif
        bit 4,a ; kan
        if z
            set Keys_Bit_Up,e
        endif

        ld a,e
    pop de
ret
