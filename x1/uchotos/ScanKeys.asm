Port_Psg_Register equ 1c00h
Port_Psg_Out equ 1b00h
Port_Psg_In equ 1b00h
Psg_Input equ 14

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

keyTable:
    ; defb '1', Keys_Left or Keys_Down
    defb '2', Keys_Down
    ; defb '3', Keys_Right or Keys_Down
    defb '4', Keys_Left
    defb '6', Keys_Right
    defb '7', Keys_Left or Keys_Button0
    defb '8', Keys_Up
    defb '9', Keys_Right or Keys_Button0
    defb 1dh, Keys_Left
    defb 1ch, Keys_Right
    defb 1fh, Keys_Down
    defb 1eh, Keys_Up
    defb 20h, Keys_Button0
    defb 0dh, Keys_Button1
    defb 'Z', Keys_Left or Keys_Button0
    defb 'X', Keys_Right or Keys_Button0
    defb 'z', Keys_Left or Keys_Button0
    defb 'x', Keys_Right or Keys_Button0
ScanKeys_:   public ScanKeys_
; out
;   a
    push bc | push de | push hl
        call ReadAscii
        ld c,0

        or a
        if nz
            ld hl,keyTable
            ld b,16
            do
                cp (hl)
                if z
                    inc hl
                    ld c,(hl)
                    jr next
                endif
                inc hl
                inc hl
            dwnz
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
    pop hl | pop de | pop bc
ret 
