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

PortABits equ 90h
PortA equ 0e8h
PortC equ 0eah
JoyPort equ 1ah

    cseg
ScanKeys_: public ScanKeys_
    push bc
        ld c,0
        di
            ld a,11h
            out (30h),a
            in a,(31h)
            bit 0,a ;GRPH
            if z
                set Keys_Bit_Button1,c
            endif
            ld b,a

            ld a,12h
            out (30h),a
            in a,(31h)
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

            ld a,14h
            out (30h),a
            in a,(31h)
            bit 0,a ;8
            if z
                set Keys_Bit_Up,c
            endif

            ld a,18h
            out (30h),a
            in a,(31h)
            bit 0,a ;Right
            if z
                set Keys_Bit_Right,c
            endif

            ld a,21h
            out (30h),a
            in a,(31h)
            bit 4,a ;Left
            if z
                set Keys_Bit_Left,c
            endif
            bit 5,a ;Up/Down
            if z
                bit 1,b
                if z
                    set Keys_Bit_Down,c
                else
                    set Keys_Bit_Up,c
                endif
            endif
            bit 7,a ;SPACE
            if z
                set Keys_Bit_Button0,c
            endif

            ld a,42h
            out (30h),a
            in a,(31h)
            bit 4,a ;J
            if z
                set Keys_Bit_Left,c
            endif
            bit 5,a ;I
            if z
                set Keys_Bit_Up,c
            endif

            ld a,44h
            out (30h),a
            in a,(31h)
            bit 5,a ;K
            if z
                set Keys_Bit_Right,c
            endif

            ld a,48h
            out (30h),a
            in a,(31h)
            bit 4,a ;M
            if z
                set Keys_Bit_Down,c
            endif
        ei

        in a,(JoyPort)
        bit 0,a
        if z
            set Keys_Bit_Up,c
        endif
        bit 1,a
        if z
            set Keys_Bit_Down,c
        endif
        bit 2,a
        if z
            set Keys_Bit_Left,c
        endif
        bit 3,a
        if z
            set Keys_Bit_Right,c
        endif
        bit 4,a
        if z
            set Keys_Bit_Button0,c
        endif

        ld a,c
    pop bc
ret

ScanStop_:
    public ScanStop_
    di
        ld a,21h
        out (30h),a
        in a,(31h)
    ei
    bit 3,a ;STOP
    if z
        ld a,1
    else    
        xor a
    endif
ret