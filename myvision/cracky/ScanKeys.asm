include "kh1000.inc"

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
    push bc
        ld c,0

        ld a,15 | out (PsgAddressPort),a
        ld a,not 80h | out (PsgWritePort),a
        ld a,14 | out (PsgAddressPort),a
        in a,(PsgReadPort)
        bit 4,a ; C/Down
        if z
            set Keys_Bit_Down,c
        endif
        bit 7,a ; 1
        if z
            set Keys_Bit_Button0,c
        endif

        ld a,15 | out (PsgAddressPort),a
        ld a,not 40h | out (PsgWritePort),a
        ld a,14 | out (PsgAddressPort),a
        in a,(PsgReadPort)
        bit 3,a ; B/Up
        if z
            set Keys_Bit_Up,c
        endif

        ld a,15 | out (PsgAddressPort),a
        ld a,not 20h | out (PsgWritePort),a
        ld a,14 | out (PsgAddressPort),a
        in a,(PsgReadPort)
        bit 3,a ; 14/Start
        if z
            set Keys_Bit_Button0,c
        endif
        bit 4,a ; D/Right
        if z
            set Keys_Bit_Right,c
        endif
        bit 7,a ; 2
        if z
            set Keys_Bit_Button1,c
        endif

        ld a,15 | out (PsgAddressPort),a
        ld a,not 10h | out (PsgWritePort),a
        ld a,14 | out (PsgAddressPort),a
        in a,(PsgReadPort)
        bit 3,a ; A/Left
        if z
            set Keys_Bit_Left,c
        endif
        bit 4,a ; E
        if z
            set Keys_Bit_Button1,c
        endif

        ld a,c
    pop bc
ret