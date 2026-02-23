include 'X1.inc'

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
ReadAscii:
    ei
    ld bc,1900h
    ld a,0e6h
    out (c),a
    ld bc,1a01h
    do
        in a,(c)
        and 40h
    while nz | wend
    di
    ld e,2
    do
        ld bc,1a01h
        do
            in a,(c)
            and 20h
        while nz | wend
        ld bc,1900h
        in a,(c)
        dec e
    while nz | wend
    ei
ret

ReadJoyPad:
    push bc
        ld bc,Port_Psg_Register
        ld a,Psg_Input
        out (c),a
        dec b
        in a,(c)
    pop bc
ret

ScanKeys_:   public ScanKeys_
; out
;   a
    push bc | push de
        call ReadAscii
        ld c,0

        cp '4'
        if z
            set Keys_Bit_Left,c
            jr next
        endif
        cp 1dh
        if z
            set Keys_Bit_Left,c
            jr next
        endif
        cp '6'
        if z
            set Keys_Bit_Right,c
            jr next
        endif
        cp 1ch
        if z
            set Keys_Bit_Right,c
            jr next
        endif
        cp '2'
        if z
            set Keys_Bit_Down,c
            jr next
        endif
        cp 1fh
        if z
            set Keys_Bit_Down,c
            jr next
        endif
        cp '8'
        if z
            set Keys_Bit_Up,c
            jr next
        endif
        cp 1eh
        if z
            set Keys_Bit_Up,c
            jr next
        endif
        cp ' '
        if z
            set Keys_Bit_Button0,c
            jr next
        endif
        cp 13
        if z
            set Keys_Bit_Button1,c
            jr next
        endif
        next:

        call ReadJoyPad
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
        bit 5,a
        if z
            set Keys_Bit_Button0,c
        endif
        bit 6,a
        if z
            set Keys_Bit_Button1,c
        endif

        ld a,c
    pop de | pop bc
ret 

ScanStop_:
    public ScanStop_
    xor a
ret
