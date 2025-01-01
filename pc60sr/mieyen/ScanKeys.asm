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
        call 0552h
        bit 5,a
        if nz
            set Keys_Bit_Left,c
        endif
        bit 4,a
        if nz
            set Keys_Bit_Right,c
        endif
        bit 3,a
        if nz
            set Keys_Bit_Down,c
        endif
        bit 2,a
        if nz
            set Keys_Bit_Up,c
        endif
        bit 0,a ;SHIFT
        if nz
            set Keys_Bit_Button1,c
        endif
        bit 7,a ;SPACE
        if nz
            set Keys_Bit_Button0,c
        endif

        ld a,1
        call 1953h
        bit 2,a
        if nz
            set Keys_Bit_Left,c
        endif
        bit 3,a
        if nz
            set Keys_Bit_Right,c
        endif
        bit 1,a
        if nz
            set Keys_Bit_Down,c
        endif
        bit 0,a
        if nz
            set Keys_Bit_Up,c
        endif
        bit 5,a
        if nz
            set Keys_Bit_Button1,c
        endif
        bit 4,a
        if nz
            set Keys_Bit_Button0,c
        endif

        ld a,c
    pop bc
ret 

ScanStop_:
    public ScanStop_
    call 1061h
    and 2
    srl a
ret
