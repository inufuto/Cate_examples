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
cseg
ScanKeys_: public ScanKeys_
    push de
        ld e,0

        ld a,0efh | out (01h),a
        in a,(01h)
        bit 0,a ;0
        if z
            set Keys_Bit_Button0,e
        endif
        bit 2,a ;4
        if z
            set Keys_Bit_Left,e
        endif

        ld a,0f7h | out (01h),a
        in a,(01h)
        bit 1,a ;2
        if z
            set Keys_Bit_Down,e
        endif
        bit 3,a ;8
        if z
            set Keys_Bit_Up,e
        endif

        ld a,0fbh | out (01h),a
        in a,(01h)
        bit 2,a ;6
        if z
            set Keys_Bit_Right,e
        endif

        ld a,0fdh | out (01h),a
        in a,(01h)
        bit 0,a ;Enter
        if z
            set Keys_Bit_Button1,e
        endif

        ld a,0feh | out (01h),a
        in a,(01h)
        bit 0,a ;Down
        if z
            set Keys_Bit_Down,e
        endif
        bit 1,a ;Left
        if z
            set Keys_Bit_Left,e
        endif
        bit 2,a ;Right
        if z
            set Keys_Bit_Right,e
        endif
        bit 3,a ;Up
        if z
            set Keys_Bit_Up,e
        endif

        ld a,e
    pop de
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    ld a,0bfh | out (01h),a
    in a,(01h)
    and 60h
    if z
        ld a,1
    else
        xor a
    endif        
ret
