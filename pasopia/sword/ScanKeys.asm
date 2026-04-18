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
PortA equ 30h
PortB equ 31h
; JoyPort equ 1ah

PortAValue equ 0fe09h

cseg
ScanKeys_:
    public ScanKeys_
    push bc
        ld c,0
        ld a,(PortAValue)
        and 80h
        ld b,a
        di
            ld a,b
            or 11h
            out (PortA),a
            in a,(PortB)
            bit 0,a ;GRPH
            if z
                set Keys_Bit_Button1,c
            endif

            ld a,b
            or 12h
            out (PortA),a
            in a,(PortB)
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

            ld a,b
            or 14h
            out (PortA),a
            in a,(PortB)
            bit 0,a ;8
            if z
                set Keys_Bit_Up,c
            endif
            bit 3,a ;Down
            if z
                set Keys_Bit_Down,c
            endif
            bit 4,a ;Up
            if z
                set Keys_Bit_Up,c
            endif

            ld a,b
            or 18h
            out (PortA),a
            in a,(PortB)
            bit 0,a ;Right
            if z
                set Keys_Bit_Right,c
            endif

            ld a,b
            or 21h
            out (PortA),a
            in a,(PortB)
            bit 5,a ;Left
            if z
                set Keys_Bit_Left,c
            endif
            bit 7,a ;SPACE
            if z
                set Keys_Bit_Button0,c
            endif
        ei

        ; in a,(JoyPort)
        ; bit 7,a
        ; if nz
        ;     bit 0,a
        ;     if z
        ;         set Keys_Bit_Up,c
        ;     endif
        ;     bit 1,a
        ;     if z
        ;         set Keys_Bit_Down,c
        ;     endif
        ;     bit 2,a
        ;     if z
        ;         set Keys_Bit_Left,c
        ;     endif
        ;     bit 3,a
        ;     if z
        ;         set Keys_Bit_Right,c
        ;     endif
        ;     bit 4,a
        ;     if z
        ;         set Keys_Bit_Button0,c
        ;     endif
        ; endif

        ld a,c
    pop bc
ret
